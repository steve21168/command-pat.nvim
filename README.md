# command-pat

## Description

Inspired by Vims global command + normal commands. Like Vim's global command, command-pat iterates through each line looking for a pattern.  With command-pat the patten is inputted via visual selection or by cword under cursor.  After searching the pattern you are prompted for a normal command and this is executed at each pattern.  This is distinct from the global command which is executed at the beginning of each line where each pattern occurs.

## Example
Given text
```
foo

other line

bar foo
```
If you were to run `:g/foo/norm ~`

The result would be:
```
Foo

other line

Bar foo
```

With command-pat: `OperateOnNSelection()` place your cursor over the first `foo` and when prompted enter the expression `~` and it will effectively search for that pattern and run the normal command resulting in:

```
Foo

other line

Bar Foo
```

## Recommended mapping
```
nnoremap <leader>d :lua require('command-pat').OperateOnNSelection()<CR>
vnoremap <leader>d :lua require('command-pat').OperateOnVSelection()<CR>
```

