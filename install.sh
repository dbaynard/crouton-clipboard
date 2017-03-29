echo "cloning crouton clipboard!"
git clone http://github.com/zwhitchcox/crouton-clipboard ~/.crouton-clipboard
touch ~/.crouton-clipboard/data.txt
echo "adding startup script to .bashrc"
cat > $HOME/.bashrc <<'EOF'
# Crouton clipboard# {{{
( ( (
   flock -n 9 && (nohup node ~/.crouton-clipboard/server.js > /dev/null 2>&1 &) && echo "Launched crouton clipboard server"
   ) 9>/var/run/lock/crouton-clipboard.lockfile
  ) || echo "Crouton clipboard server already running."
 )
# }}}
EOF
echo "adding copy/paste commands to vimrc"
echo "nnoremap \"*p :r !cat $HOME/.crouton-clipboard/data.txt<CR>\nvnoremap \"*y :'<,'>w! $HOME/.crouton-clipboard/data.txt<CR>" >> ~/.vimrc
echo "starting crouton clipboard!"
source $HOME/.bashrc
