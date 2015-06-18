function Pout = transformPointCloud2D(P,T)

P2 = [P ones(size(P,1),1)]; % convert to homogeneous 2D coordinates

Pout = (T * P2')'; % apply transformation

Pout = Pout(:,1:2); % convert back to regular x/y coordinates
