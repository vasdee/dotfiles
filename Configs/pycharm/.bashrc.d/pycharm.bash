
PYCHARM_PATH="/opt/pycharm/bin/"

if [[ ! ":$PATH:" == *:"$PYCHARM_PATH":* ]]; then
   PATH=$PYCHARM_PATH:$PATH
fi
