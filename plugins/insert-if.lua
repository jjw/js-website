-- Inserts an HTML snippet iff the page has a certain element
--
-- [widgets.blink-warning]
--   widget = "conditional-insert"
--   html = "<div><strong>Warning: blink elements are obsolete!</strong></div>"
--   selector = "body"
--   check_selector = "blink"
--
-- Author: Daniil Baturin
-- License: MIT

-- Configuration
snippet = config["html"]
selector = config["selector"]
check_selector = config["check_selector"]

-- Plugin code

if not snippet then
  Log.warning("Missing html option, using an empty string")
  snippet = ""
end

if (not selector) or (not check_selector) then
  Log.warning("selector and check_selector options must be configured")
else
  elem = HTML.select_one(page, check_selector)
  if elem then
    target = HTML.select_one(page, selector)
    if not target then
      Log.info("Page has no element matching selector " .. selector)
    else
	  env = {}
	  env["src"] = String.trim(HTML.inner_html(elem)) -- filename
	  if String.length(env["src"]) <= 0 then
	    env["src"] = HTML.get_attribute(elem, "src")
	  end
	  Log.debug("found " .. env["src"])
	  if String.length(env["src"]) <= 0 then
		Log.info("Node has no content or src attribute")
	  else
		html = String.render_template(snippet, env)
		snippet_html = HTML.parse(html)
	    HTML.append_child(target, snippet_html)
	  end
    end
  end
end

