% 1)
x = [-1; 0; 1; 4; 9; 2; 1; 4.5; 1.1; -0.9];
y = [1, 1, 2, 2, 3, 3, 4, 4, 5, nan]';

% 2
length(x)==length(y)
size(x,1)==size(y,1)

% 3
x < y
x < 0
x+3 >= 0
y < 0

% 4
all(x+3>=0) && all(y>0)

% 5
all(x+3>=0) || all(y>0)

% 6
any(y>0)

% 7
x+y
x*y
x*y'
x'*y
y/x
x/y

% 8
x.*y
y./x

% 9
log(x)
exp(x)

% 10
any(sqrt(x)>=2)

% 11
a = sum(x)
b = sum(y.^2,'omitnan')

% 12
sum(x.*y.^2,'omitnan')

% 13
sum(x>0)

% 14
x.^y
x.^(1/y)
log(exp(y))
y*[-1,1]
x+[-1,0,1]
sum(y*[-1,1],1,'omitnan')

% 15
X = [1 4 7;
     2 5 8;
     3 6 9];

transpose(X)
X'
size(X)
det(X)

% 16
trace(X)
sum(diag(X))

% 17
X
X([1 5 9])=[7 8 9]
X

% 18
eigvalX = eig(X);
if all(eigvalX>0)
    fprintf('X is positive definite\n')
elseif all(eigvalX>=0)
    fprintf('X is positive semi-definite\n')
elseif all(eigvalX<0)
    fprintf('X is negative definite\n')
elseif all(eigvalX<=0)
    fprintf('X is negative semi-definite\n')
else
    fprintf('X is neither positive nor negative (semi-)definite\n')
end

% 19
invX = inv(X);
eig(invX)
1./eigvalX % these are the same eigenvalues

% 20
a = [1;3;2];
a'*X
a'.*X
X*a

% 21
a'*X*a

% 22
I = eye(3);
X = reshape(1:9,3,3);
Y = [X I]
Z = [X;I]

% 23
x1 = 1:9
x2 = repmat([0 1],1,4)
x3 = repmat(1,1,8)
x4 = repmat([-1 1],1,3)
x5 = 1980:5:2010
x6 = 0:0.01:1

% 24
linspace(-pi,pi,500)

% 25
1:10+1
(1:10)+1
1:(10+1)

% 26
x = [1 1.1 9 7 1 4 4 1]';
y = [1 2 3 4 4 3 2 nan]';
z = [true true false false true false false false];

% 27
x(2:5)
x(4:end-2)
x([1 5 8])
x(repmat(1:3,1,4))
y(z)
y(~z)
y(x>2)
y(x==1)
x(~isnan(y))
y(~isnan(y))

% 28
x2 = x;
x2(x2==4) = -4;
x2

% 29
x2(x2==1) = nan;
x2

% 30
x2(z) = [];
x2

% 31
M = reshape([1:12 12:-1:1],4,6);

% 32
M(1,3)
M(:,5)
M(2,:)
M(2:3,3:4)
M(2:4,4)
M(M>5)
M(:,M(1,:)<=5)
M(M(:,2)>6,:)
M(M(:,2)>6,4:6)

% 33
find(M(:,5)>3*M(:,6))

% 34
sum(M>7,'all')

% 35
sum(M(2,:) < M(1,:))

% 36
sum( M(:,2:end) > M(:,1:end-1) ,'all')