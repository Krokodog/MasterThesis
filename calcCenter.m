function [avgNormal,avgWind] = calcCenter(cfg)

avg1x=0;
avg1y=0;
avg2x=0;
avg2y=0;

for i= 1:cfg.swarmSize
        avg1x=avg1x+cfg.swarm(i,1);
        avg1y=avg1y+cfg.swarm(i,2);
        avg2x=avg2x+cfg.swarmV(i,1);
        avg2y=avg2y+cfg.swarmV(i,2);
end

avgNormal=[avg1x/cfg.swarmSize,avg1y/cfg.swarmSize];
avgWind=[avg2x/cfg.swarmSize,avg2y/cfg.swarmSize];