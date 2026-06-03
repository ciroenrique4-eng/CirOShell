function sboost --wraps='env DISPLAY=:0 nvidia-settings -a "[gpu:0]/GPUPowerMizerMode=1" && sudo sh -c "/usr/bin/nvidia-smi -pm 1 && /usr/bin/nvidia-smi -lgc 2000,3000"' --description 'alias sboost=env DISPLAY=:0 nvidia-settings -a "[gpu:0]/GPUPowerMizerMode=1" && sudo sh -c "/usr/bin/nvidia-smi -pm 1 && /usr/bin/nvidia-smi -lgc 2000,3000"'
    env DISPLAY=:0 nvidia-settings -a "[gpu:0]/GPUPowerMizerMode=1" && sudo sh -c "/usr/bin/nvidia-smi -pm 1 && /usr/bin/nvidia-smi -lgc 2000,3000" $argv
end
