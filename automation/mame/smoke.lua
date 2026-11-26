local result_path = os.getenv("COCO3_RESULT_PATH")
local screenshot_path = os.getenv("COCO3_SCREENSHOT_PATH")

local function json_string(value)
    value = tostring(value or "")
    value = value:gsub("\\", "\\\\")
    value = value:gsub("\"", "\\\"")
    value = value:gsub("\r", "\\r")
    value = value:gsub("\n", "\\n")
    return "\"" .. value .. "\""
end

local function write_json(result)
    local file = assert(io.open(result_path, "w"))
    file:write(result)
    file:close()
end

local frames_to_wait = 120
local completed = false

local function collect_evidence()
    if completed then
        return
    end
    completed = true

    local machine = manager.machine
    local screen = machine.screens[":screen"]
    local images = {}

    for tag, image in pairs(machine.images) do
        images[#images + 1] = string.format(
            "{\"tag\":%s,\"instance\":%s,\"mounted\":%s,\"readonly\":%s,\"filename\":%s}",
            json_string(tag),
            json_string(image.instance_name),
            tostring(image.exists),
            tostring(image.readonly),
            image.filename and json_string(image.filename) or "null"
        )
    end

    local screenshot_error = "screen unavailable"
    if screen then
        screenshot_error = screen:snapshot(screenshot_path)
    end
    local status = screenshot_error and "failed" or "passed"
    local error_value = screenshot_error and json_string(screenshot_error) or "null"

    local result = string.format(
        "{" ..
        "\"schema_version\":1," ..
        "\"status\":%s," ..
        "\"operation\":\"inspect\"," ..
        "\"emulator\":{\"name\":%s,\"version\":%s}," ..
        "\"target\":{\"system\":%s}," ..
        "\"input\":{\"natural_keyboard_available\":%s}," ..
        "\"screen\":{\"width\":%d,\"height\":%d}," ..
        "\"media\":[%s]," ..
        "\"evidence\":{\"screenshot\":%s}," ..
        "\"error\":%s" ..
        "}",
        json_string(status),
        json_string(emu.app_name()),
        json_string(emu.app_version()),
        json_string(machine.system.name),
        tostring(machine.natkeyboard.can_post),
        screen and screen.width or 0,
        screen and screen.height or 0,
        table.concat(images, ","),
        json_string(screenshot_path),
        error_value
    )

    write_json(result)
    machine:exit()
end

assert(result_path, "COCO3_RESULT_PATH is required")
assert(screenshot_path, "COCO3_SCREENSHOT_PATH is required")

local frame_count = 0
emu.register_frame_done(function()
    frame_count = frame_count + 1
    if frame_count >= frames_to_wait then
        collect_evidence()
    end
end, "coco3-smoke")
