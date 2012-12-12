Custom Git Hooks
================

Simple repository to store custom git hooks.

#Installation

Copy custom_git_hooks into the root of your project.

```sh
# cd /path/to/root/of/app
# cd .git/hooks/

ln -sf ../../hooks/pre_commit/pre_commit_flog.rb pre_commit_flog.rb
ln -sf ../../pre-commit.sh pre-commit
```

If the file exists it will use them, and will silently ignore them if they don't.
