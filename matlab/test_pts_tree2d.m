clear srcinfo

ns = 4000;
sources = zeros(2,ns);

  theta=rand(1,ns)*pi;
  phi=rand(1,ns)*2*pi;
  sources(1,:)=.5*cos(phi);
  sources(2,:)=.5*sin(phi);

srcinfo.sources = sources;

nt = 3999;
targ = rand(2,nt);

eps = 1e-5;
ntests = 1;
ipass = zeros(ntests,1);
errs = zeros(ntests,1);
ntest = 10;

stmp = srcinfo.sources(:,1:ntest);
ttmp = targ(:,1:ntest);

itest = 1;
zk  = 1.1 + 1j*0.1;


% Test tree
opts.ndiv = 20;
[U,ixy,ixyse] = pts_tree2d(srcinfo,opts);

  nlevels = U.nlevels;
  nboxes = U.nboxes;
  ltree = U.ltree;
  itree = U.itree;
  iptr = U.iptr;
  centers = U.centers;
  boxsize = U.boxsize;

% plot  
  level = itree(iptr(2):iptr(3)-1);
  nchild = itree(iptr(4):iptr(5)-1);
  sources_sort = sources(:,ixy);
  figure(1),clf,hold on,
  for k=1:nboxes
      if nchild(k)==0 % no children
          % plot(centers(1,k),centers(2,k),'.k')
          nodesX = centers(1,k) + boxsize(level(k))/2*[1,-1,-1,1]/2; % why divided by 4?
          nodesY = centers(2,k) + boxsize(level(k))/2*[1,1,-1,-1]/2;
          plot(nodesX,nodesY,'-k')
          % 
          if ixyse(2,k) > ixyse(1,k) % plot pts box by box (some does not have any)
              sources_sort_k = sources_sort(:,ixyse(1,k):ixyse(2,k));
              plot(sources_sort_k(1,:),sources_sort_k(2,:),'.')  
              pause(0.01)
          end
      end
  end

% how to check this is a success?  

keyboard