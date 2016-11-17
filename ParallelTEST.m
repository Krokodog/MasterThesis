clc;
A=ones(2000);
B=A;
C=A;
D=A;
E=A;
F=A;
G=A;

tic;
counter=1;
for i=1:size(A,1)
    for j=1:size(A,2)
    A(i,j)=A(i,j)*counter^3;
    counter=counter+1;
    end
end
doubleFor=toc

tic;
B=B(:);
for i=1:size(A,1)*size(A,1)
    B(i)=B(i)*i^3;
end
B=vec2mat(B,size(A,1));
vectorizedVec2Mat=toc

tic;
C=C(:);
for i=1:size(A,1)*size(A,1)
    C(i)=C(i)*i^3;
end
C=reshape(C,size(A,1),size(A,1));
C=C.';
vectorizedReshape=toc

tic;
D=D(:);
spmd
        for i=1:size(A,1)*size(A,1);
            D(i)=D(i)*i^3;
        end
end
D1=reshape(D{1},size(A,1),size(A,1));
D2=reshape(D{2},size(A,1),size(A,1));
D3=reshape(D{3},size(A,1),size(A,1));
D1=D1.';
D2=D2.';
D3=D3.';
pp3=toc/3

tic;
counter=1;

spmd
for i=1:size(A,1)
    for j=1:size(A,2)
    E(i,j)=E(i,j)*counter^3;
    counter=counter+1;
    end
end
end
spmd3doublefor=toc/3

tic;
G=G(:);
parfor i=1:size(A,1)*size(A,1)
   
    G(i)=G(i)*i^3;
end
G=reshape(G,size(A,1),size(A,1));
G=G.';
parfortime=toc

% Not working properly
% tic;
% spmd
%   X = codistributed(F);  
%     coun1=1;
%     for i=1:size(getLocalPart(X),2)
%         for j=1: size(getLocalPart(X),1)
%         F(i,j)=F(i,j)*coun1^3;
%         coun1=coun1+1;
%         end
%     end
% 
% end
% spmdDistributed=toc


