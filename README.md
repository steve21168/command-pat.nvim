# command-pat

## Description

Inspired by Vims global command + normal commands. Like Vim's global command, command-pat iterates through each line looking for a pattern.  With command-pat the patten is inputted via cword under cursor, visual selection or by a pattern itself.  After searching the pattern you are prompted for a normal command and this is executed at the start of each pattern.  This is distinct from the global command which executes at the beginning of each line where the pattern occurs.

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

bar Foo
```

## Functions to map
```
:lua require('command-pat').OperateOnPattern()<CR> -- Map in any mode
:lua require('command-pat').OperateOnNSelection()<CR> -- Map in normal mode
:lua require('command-pat').OperateOnVSelection()<CR> -- Map in visual mode
```
