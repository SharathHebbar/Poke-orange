sed -i 's/\<'$1'\>/'$2'/' $(grep -lwr --include="*.asm" --exclude-dir="utils" --exclude-dir=".git" --exclude-dir="patches" --exclude-dir="tools" $1)
# $1: phrase to find
# $2: phrase to replace $1