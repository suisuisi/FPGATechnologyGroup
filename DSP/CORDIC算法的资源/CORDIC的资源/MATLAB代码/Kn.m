close all;
clear;
clc;
% 初始化
die = 16;%迭代次数
jiao = zeros(die,1);%每次旋转的角度
cos_value = zeros(die,1);%每次旋转的角度的余弦值
K = zeros(die,1);%余弦值的N元乘积
K_1 = zeros(die,1);%余弦值的N元乘积的倒数
for i = 1 : die
    a = 2^(-(i-1));
    jiao(i) = atan(a);
    cos_value(i) = cos(jiao(i));
    if( i == 1)
        K(i) = cos_value(i);
        K_1(i) = 1/K(i);
    else
        K(i) = K(i-1)*cos_value(i);
        K_1(i) = 1/K(i);
    end
end
jiao = vpa(rad2deg(jiao)*256,10) 
cos_value = vpa(cos_value,10)
K = vpa(K,10)
K_1 = vpa(K_1,10)
