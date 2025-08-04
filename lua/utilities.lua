function get_header()
  local returned="Good ";
  local hour = tonumber(os.date("%H"));
  local minute = tonumber(os.date("%M"));
  if hour > 18 then
    returned=returned.."evening, ";
  elseif hour > 12 then
    returned=returned.."afternoon, ";
  elseif hour > 22 then
    returned=returned.."night, ";
  elseif hour > 0 then
    returned=returned.."morning, ";
  end
  returned=returned..os.getenv("USER");
  returned=returned.."\n";

  returned = returned .. string.rep("─", #returned - 1)

  return returned;
end
function find_project_root()
  local path = vim.fn.expand("%:p:h")  -- start in buffer's dir
  while path and path ~= "/" do
    if vim.fn.filereadable(path .. "/Makefile") == 1 then
      return path
    end
    path = vim.fn.fnamemodify(path, ":h")
  end
  return vim.fn.getcwd() -- fallback
end

