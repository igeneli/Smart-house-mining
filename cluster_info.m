% this function is used to monitoring the clustering info. of specific node while merging
% e.g. [degreeMF, sensorInfo] = cluster_info (newFG, find(group == 1) , dffa.FrequencyTransitionMatrix{8}, 30)
function [degreeMF, sensorInfo] = cluster_info (graph, cluster_members , node_symbol, alphabet_len)

% the sensor information within the cluster, i.e. which sensor is contained in this cluster, and how many(this is not the freq info. each state count for 1)
sensorInfo = zeros(1, alphabet_len);

for i = 1:length(cluster_members(:,1))
    withind = 0;
    ind =  0;
    outd = 0;
    for j = 1:length(cluster_members(1,:))
        if (cluster_members(i,j) == 0)
            break;
        else
            temp = find(graph(cluster_members(i,j),:) ~=0);
            
            for k = 1:length(temp)
                outd = outd + graph(cluster_members(i,j),temp(k));
                if (~isempty(find(cluster_members(i,:) == temp(k))))
                    outd = outd - graph(cluster_members(i,j),temp(k));
                    withind = withind + graph(cluster_members(i,j),temp(k));
                    
                end
            end
            
            temp1 = find(graph(:,cluster_members(i,j))~=0);
            
            for m =1:length(temp1)
                ind = ind + graph(temp1(m),cluster_members(i,j));
                if (~isempty(find(cluster_members(i,:) == temp1(m))))
                    ind = ind - graph(temp1(m),cluster_members(i,j));
                end
            end
            
            
        end
        
        if (cluster_members(i,j) ~= 1)
            tmp_idx = node_symbol(cluster_members(i,j));
            sensorInfo(tmp_idx) = sensorInfo(tmp_idx) + 1;
        end
        
    end
    degreeMF(i,1) = ind;
    degreeMF(i,2) = outd;
    degreeMF(i,3) = withind;
    degreeMF(i,4) = (ind + outd)/withind;
    
end


end
