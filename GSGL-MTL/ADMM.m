function [theta] = ADMM(A,y,lambda1,lambda2,lambda3,opts)

    Print = opts.Print;
    Dimen = opts.Dimen;
    MaxIter = opts.MaxIter;
    rho = opts.rho;
    Tol = opts.Tol;
    Tasks = opts.Tasks;
    ind = opts.ind;
    alpha = 1;    
    
    I = eye(Dimen); 
    bv = A'*y;
    CC = A'*A + rho*I;
    Ch_R = dpotrf_(CC);    
            
    mu = zeros(Dimen,Tasks);
    q = zeros(Dimen,Tasks);
    u = zeros(Dimen,Tasks);
    p = zeros(Dimen,Tasks);
    theta_p = zeros(Dimen,Tasks);
    
    ind_work1(1:2,:)=ind(1:2,:);
    ind_work1(3,:)=ind(3,:) * (lambda1 / rho);
    
    ind_work2(1:2,:)=ind(1:2,:);
    ind_work2(3,:)=ind(3,:) * (lambda2 / rho);
    
    if Print
        fprintf('%3s\t%10s\t%10s\t%10s\t%10s\n','iter','funv', 'Tol tv', 'td', 'Tol tz');
    end
      
    for iter = 1:MaxIter

        thetat = bv-mu+rho*q;
        for k = 1:Tasks
            theta(:,k) = dpotrs_(Ch_R,thetat(:,k));
        end
        theta = alpha*theta + (1 - alpha)*theta_p;
        
        q = theta + mu/rho;
        q = shrinkage_g(q, ind_work1, size(ind_work1,2), Dimen, Tasks);
        q = shrinkage_gm(q, ind_work2, size(ind_work2,2), Tasks);
        q = shrinkage_21(q,lambda3/rho);
       
        mu = mu + rho*(theta - q);
        
        funv(iter) = norm(theta-q);
        td = norm(theta-theta_p);
        
        if iter > 1
            tv = max(1,funv(iter-1));
            tz = max(1,td);
            if Print
                fprintf('%3d\t%10.4f\t%10.4f\t%10.4f\t%10.4f\n',iter,funv(iter), Tol*tv,td,Tol*tz);
             end
            if funv(iter) < Tol*tv && td < Tol*tz
                break;
            end
        end
        
        theta_p = theta;
        
    end
    theta = q;
        
function w = shrinkage_21(W,lambda_3)

    for i = 1:size(W,1)
        w_1 = W(i,:);
        nm = norm(w_1, 2);
        if nm == 0
            w_2 = zeros(size(w_1));
        else
            w_2 = max(nm - lambda_3, 0)/nm * w_1;
        end
        w(i,:) = w_2;
    end
    
function x = shrinkage_g(v, ind, nodes, nd, nt)
    x = reshape(v,nd*nt,1);
    for i = 1:nodes
        temp = ind(:,i);
        j = temp(1):temp(2);
        twoNorm = sqrt(sum(x(j,1).^2));
        lambda = temp(3);
        if twoNorm > lambda
            ratio = (twoNorm - lambda)/twoNorm;
            x(j,1) = x(j,1) * ratio;
        else
            x(j,1) = 0;
        end
    end
    x = reshape(x,nd,nt);

function x = shrinkage_gm(x, ind, nodes, nt)
    nodes = nodes/nt;
    for i = 1:nodes
        temp = ind(:,i);
        j = temp(1):temp(2);
        twoNorm = norm(x(j,:),'fro');
        lambda = temp(3);
        if twoNorm > lambda
            ratio = (twoNorm - lambda)/twoNorm;
            x(j,:) = x(j,:) * ratio;
        else
            x(j,:) = 0;
        end
    end
    
    
    