pth = 'D:\ms\gblur';
d = dir(pth);
d = d(3:end);
n = length(d);
score = zeros(1,n);

CoreNum=4; %�趨����CPU�����������ҵĻ�����˫�ˣ�����
if matlabpool('size')<=0 %�жϲ��м��㻷���Ƿ���Ȼ����
    matlabpool('open','local',CoreNum); %����δ���������������л���
else
    disp('Already initialized'); %˵�����л����Ѿ�������
end

for gsize = 3:8
    for gsigma = 3:10
        for k = 3:2:9
            for step = 1:k
                h = fspecial('gaussian',gsize,gsigma);
                tic
                parfor i = 1:n
                    im = imread([pth '\img' num2str(i) '.bmp']);
                    im = im2double(rgb2gray(im));
                    score(i) = iqa(im,h,k,step);
                    %i,score(i)
                end
                save([num2str(gsize) '.' num2str(gsigma) '.' num2str(k) '.' num2str(step) '.mat'],'score');
                toc
            end
        end
    end
end
matlabpool close;