clear
load phosphorous2.mat


for aa = 1:9

% n=1;
% M = [datanad3; datanadex];
% Rodentia	Hydrochoeridae	Neochoerus	sulcidens
% Notoungulata	Toxodontidae	Mixotoxodon	spp.
% Notoungulata	Toxodontidae	Toxodon	paradoxus
% Notoungulata	Toxodontidae	Toxodon	burmeisteri
% Notoungulata	Toxodontidae	Toxodon	bilobidens
% Xenarthra	    Megatheriidae	Eremotherium	rusconii
% Proboscidea	Gomphotheriidae	Cuvieronius	spp.
% Proboscidea	Gomphotheriidae	Haplomastodon	chimborazi
% Proboscidea	Gomphotheriidae	Stegomastodon	superbus
xv = [ 150 1000 1000 1100 1100 3500 5000 6000 7580]';
%xv = [ 3500 6000 5000 1100 1100 1500 1100]';
xv = [ 3500 3500 6000 5000 5000 1100 1100 1100 1100 1500 1500 1100 1100 1100 1100 3500 1700 1700 2000 2000 7580]';

if aa==1
    xv2=xv;    
elseif aa==2
    iu = find(xv<7000);
    xv2=xv(iu);
elseif aa==3
    iu = find(xv<6000);
    xv2=xv(iu);
elseif aa==4
    iu = find(xv<5000);
    xv2=xv(iu);
elseif aa==5
    iu = find(xv<4000);
    xv2=xv(iu);
elseif aa==6
    iu = find(xv<3000);
    xv2=xv(iu);
elseif aa==7
    iu = find(xv<2000);
    xv2=xv(iu);
elseif aa==8
    iu = find(xv<1000);
    xv2=xv(iu);
elseif aa==9
    iu = find(xv<000);
    xv2=xv(iu);
end    

M = xv2;
if ~isempty(M)
for M1 = 1:length(M)
 
    Ds(M1) = (365*0.78*((0.054*M(M1)^1.17 )/500000));%edible plant matter (roots litter)


end
megsp = nansum(Ds)
else
megsp = 0   
end

clear Ds





x=wetmask3;
x(find(x==0))=2;
x(find(x==127))=0;%0.00001;
x(find(x==255))=1;
x(find(x==208))=1;


%draw dust input using imfreehand
% h_im = imshow(wetmask3);
% H = IMFREEHAND
% BW = createMask(H,h_im);

%take data from animal ranges and interpolate
% [xi,yi] = meshgrid(1:.015:27,1:.015:27);
%if use zzzphi = ((PHI(86:114, 106:134)));
%[xi,yi] = meshgrid(1:.018:29,1:.018:29);
% zi = interp2(xtest,xi,yi, 'nearest');
% imagesc(log10(zi))
% z2 = zi(1:1500,1:1500);

n=1;
m=1;
d1=30;

for i = 1:d1:1500-d1
    for j = 1:d1:1500-d1
        x1(n,m) = nanmean(nanmean(x(i:i+12,j:j+12)));
        du1(n,m) = nanmean(nanmean(dustin2(i:i+12,j:j+12)));
        hi1(n,m) = nanmean(nanmean(higgins(i:i+12,j:j+12)));
        so1(n,m) = nanmean(nanmean(soilmois(i:i+12,j:j+12)));
        an1(n,m) = nanmean(nanmean(animalD2(i:i+12,j:j+12)));
        bo1(n,m) = nanmean(nanmean(boundary2(i:i+12,j:j+12)));
        m=m+1;
    end
    n=n+1;
    m=1;
end
x1=x1-1;
x1(find(x1>-1 & x1<0))=0;
xmask=x1;
xmask(find(xmask>-0.0000001))=1;
xmask(find(xmask<0))=0;


bo1(find(bo1<6))=0;
bo1(find(bo1==6))=1;
% define the constants for the problem
      M = 4000; % number of time steps
      L = 49; % length and width of plate
      k = 10; % constant
      N = 49; % number of elements in plate (NxN)
      %h = L/(N-1); % grid spacing
      h = 2.024*d1; % grid spacing
      x = [0:h:L]; % vector of x values
      y = [0:h:L]; % vector of y values
%
      [xx yy] = meshgrid(x,y);
      
%%Buendia loss rate
kl=0.1;%runoff leakage rate at saturation year-1
%This variable was not given in the paper, I contacted Buendia and she said
%that c=3 as the exponent of ruonoff/leakage function.
cc=3;% 
%Drainage and runoff
nn = 0.4;%porosity
Zr = 1;%meters effective soil depth
%loss of dissolved inorganic P pool gP m-2 yr-1
kr = 0.002;%losses regulation rate
kf = 0.00005;% ice wind human fire loss rate 0.0005



%add diffusion term
%mean D before = 0.2194,mean D now = 0.0440
%(2.8*M^0.77 )*0.00056, M=612 or 76kg
%1.51 vs 7.17 need to convert to pixel size
%0.0779 vs 2.92
      
      dit1=(an1+megsp);
      %dit1=an1;%units of km2/yr
      for i = 1:N
          for j= 1:N
              v = (k*dit1(i,j))/(h^2);
              a1(i,j) = (1+2*v);
              c1(i,j) = -v/2;
              f1(i,j) = (1-2*v);
              e1(i,j) = v/2;
          end
      end
      a2=a1(:);
      c2=c1(:);
      f2=f1(:);
      e2=e1(:);
      

a = 1;
c = 2;
d = 3;
e = 4;
      
      
% set the matrix for H
    A = a*eye(N) + c*diag(ones(1, N-1), 1) + c*diag(ones(1, N-1),-1);
    B = c*eye(N);
    D = d*eye(N) + e*diag(ones(1, N-1), 1) + e*diag(ones(1, N-1),-1);
    E = e*eye(N);
    C = zeros(N);

% Create the matrix H, composed of sub-matrices A,B and C
    Ap = eye(N);
    Bp = diag(ones(1, N-1), 1) + diag(ones(1, N-1), -1);
    Dp = eye(N);
    Ep = diag(ones(1, N-1), 1) + diag(ones(1, N-1), -1);
    Cp = ones(N) - Ap - Bp;
%
% Define the H_1 matrix using KRON to "replace" 1's in Ap, Bp, and Cp with copies of A, B, and C
    H_1 = kron(Ap, A) + kron(Bp, B) + kron(Cp, C);
% Define the H_2 matrix using KRON to "replace" 1's in Ap, Bp, and Cp with copies of A, B, and C
    H_2 = kron(Dp, D) + kron(Ep, E) + kron(Cp, C);
%
for i = 1:2401
    yv = H_1(i,:);
    yv(yv==1)=a2(i);
    yv(yv==2)=c2(i);
    H_1(i,:)=yv;
    
    yv2 = H_2(i,:);
    yv2(yv2==3)=f2(i);
    yv2(yv2==4)=e2(i);
    H_2(i,:)=yv2;
end


[SS_1,UU_1,PP_1] = lu(H_1);


% set up initial conditions for plate


    % set hot or cold spot, 1.50 mg g-1, assume mean LAI 4-5, SLA 100 g m-2 = 500Mg km-2 = 600 kg km2  
    %set values at 600, assume samll local weathering rate of 50 kg km2
    x2=x1;
    for i = 1:N
        for j=1:N
            if x1(i,j)>0 && hi1(i,j)==0
                x2(i,j)=x1(i,j)*600 +(1-x1(i,j))*2.5;
            elseif hi1(i,j)>0 && x1(i,j)==0
                x2(i,j)=hi1(i,j)*300 +(1-hi1(i,j))*2.5; 
            elseif hi1(i,j)>0 && x1(i,j)>0
                x2(i,j)=x1(i,j)*600 +(1-x1(i,j))*300;
            else
                x2(i,j)=.1; 
            end
            
        end
    end
    x2(find(x2<0))=.1;
    u=x2;
    %u=uut;
    u = u(:);
    du=du1(:);
    so=so1(:);
    hi=hi1(:);
    an=an1(:);
    x3 = x2(:);
    x32 = x1(:);
    ux=u;
    xmask2 = xmask(:);
z=1;
    
for m = 1:M
        
        b = H_2*u;
        u = UU_1\(SS_1\(PP_1*b));

        % replace source/sink value
    
        for i=1:length(u)
            if x3(i)>10
                if (u(i)-x3(i))>0
                    u(i)=x3(i)+ (u(i)-x3(i));
                else
                    u(i)=x3(i);
                end
            end
            
            if hi(i)>0
                
                
            end
            if u(i)< .1
                u(i)=.1;
            end
        end
     
    %add dust gain and leaching loss rates
    sm=so;
    LQ=kl.*sm.^cc;% - eq 7
    Od = (LQ./(nn.*Zr.*sm)).*k;% eq 8
    %loss of P in organic form gP m-2 yr-1 eq 9
    Oo = (kr.*LQ +kf).*k;% eq 9 remove kf because no ice little fire
    %Oo = (kr.*LQ).*k;% eq 9 
    %Oo = 0.00025;     
    u=u+du.*k.*365*.01;%dust per year
    %u=u-Oo.*u;
    u=u-(Oo.*u*0.9995+Od.*u*0.0005);
    %u=u-(Oo.*u);
    lr=(Oo.*u*0.9995+Od.*u*0.0005);
    lrd=Od.*u*0.0005;
    diffg = u-ux;
    ux=u;
    %multiply by 0 the outer regions
    uv=u.*xmask2;
    uv(find(uv==0))=NaN;
    utot(m)=nanmean(uv);
    utoteast(m) = u(1506);
    utotwest(m) = u(620);
    zz=1:50:M;
    if length(find(m==zz))==1
        umap(z,:)=u;
        lrmap(z,:)=lr;
        lrdmap(z,:)=lrd;
        diffgmap(z,:)=diffg;
        z=z+1;
    end   
    
end

for i=1:length(u)
    if x32(i)<0 
        u(i)=0;
        umap(:,i)=0;
        lrmap(:,i)=0;
        lrdmap(:,i)=0;
        diffgmap(:,i)=0;
    end
end
uu = reshape(u,N,N);

[xi,yi] = meshgrid(1:.15:60,1:.15:50);
zi = interp2(uu,xi,yi);
[xz1,xz2] = size(zi);

zxc = zeros(49,10);
for i=1:z-1
    umapz = [(reshape(umap(i,:),N,N)) zxc];
    umap3d(:,:,i) = interp2(umapz,xi,yi);
    
    %pause
end

xmazs = (umap3d(:,:,end));

mapallz(aa) = nansum(xmazs(:));
end
thresh = [8000 7000 6000 5000 4000 3000 2000 1000 0 ];
plot(thresh, mapallz/mapallz(1)*100)
xlabel('Size threshold (kg)')
ylabel('Percent of original')