local M = {}

local get_cwd = ya.sync(function()
	return tostring(cx.active.current.cwd)
end)

function M:entry(job)
	local channel = job.args[1] or "files"
	ya.emit("escape", { visual = true })
	local cwd = get_cwd()

	-- text: takeover mode. Let tv keep stdio so it can
	-- launch nvim right at the match and block the session.
	if channel == "text" then
		local permit = ui.hide()
		local child, err = Command("tv")
			:arg(channel)
			:cwd(cwd)
			:stdin(Command.INHERIT)
			:stdout(Command.INHERIT)
			:stderr(Command.INHERIT)
			:spawn()

		if child then
			child:wait()
		else
			ya.notify({ title = "TV Error", content = "Failed to start: " .. tostring(err), level = "error" })
		end
		permit:drop()
		return
	end

	-- files/dirs: selector mode. Capture the selection and
	-- reveal the chosen entry back in Yazi.
	local tmp = os.tmpname()
	local permit = ui.hide()
	local child, err = Command("sh")
		:arg("-c")
		:arg(string.format('tv %s > %q', channel, tmp))
		:cwd(cwd)
		:stdin(Command.INHERIT)
		:stdout(Command.INHERIT)
		:stderr(Command.INHERIT)
		:spawn()

	if child then
		child:wait()
	else
		ya.notify({ title = "TV Error", content = "Failed to start: " .. tostring(err), level = "error" })
	end
	permit:drop()

	local f = io.open(tmp, "r")
	if f then
		local line = f:read("*all"):gsub("[\r\n]+$", "")
		f:close()
		os.remove(tmp)

		if line ~= "" then
			local target = Url(line)
			if not target.is_absolute then
				target = Url(cwd):join(line)
			end
			ya.emit("reveal", { target })
		end
	end
end

return M