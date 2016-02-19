function fish_right_prompt -d 'bobthefish is all about the right prompt'
  set_color normal 
  echo -n '['
  set_color blue
  echo -n (prompt_pwd)
  set_color --bold purple
  echo -n (__git_branch)
  set_color normal
  echo -n '|'
  echo -n (__git_modified)
  set_color --bold normal
  echo -n ']'
end

function __git_branch -S -d 'Get the current git branch (or commitish)'
  set -l ref (command git symbolic-ref HEAD ^/dev/null)
  if [ $status -gt 0 ]
    set -l branch (command git show-ref --head -s --abbrev | head -n1 ^/dev/null)
    set ref "$branch"
  end
  echo $ref | sed "s#refs/heads/#$__bobthefish_branch_glyph #"
end

function __git_modified 
  set changes (command git status | grep 'modified:' | wc -l)
  if [ changes -eq 0 ]
    set_color blue
    echo -ns '✚' $changes
  else
    set_color --bold green
    echo '✔'
  end
end
