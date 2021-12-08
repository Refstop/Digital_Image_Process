% blur examples
% (C) 2002 by Yu Hen Hu
% created: 10/10/2002
% call motionblur.m

clear all

% load image
f=imread('matlabImage.jpg');
[m,n]=size(f);

winsize=input('Blur operator window size (an odd number, default = 9): ');
if isempty(winsize), winsize=9; 
elseif rem(winsize,2)==0, 
   winsize=winsize+1;
   disp(['Use odd number for window size = ' int2str(winsize)])
end

disp(['1. Linear motion blur;'])
chos=input('Enter a number to choose type of blur applied (default = 1): ');
if isempty(chos), chos=1; end
if chos==1, 
   dirangle=input('Bluring direction (an angle in degrees, default = 45) = ');
   if isempty(dirangle), dirangle=45; end
   h=motionblur(dirangle,winsize);
end

F=fft2(f);
Hmat=fft2(h,m,n);
Gmat=F.*Hmat;
g=ifft2(Gmat);
figure(1),
subplot(121),imagesc(f),colormap('gray'),title('original image')
subplot(122),imagesc(abs(g)),colormap('gray'),title('blurred image')
figure(2),
subplot(212),imagesc(log(1+abs(Gmat))),colormap('gray'),title('blurring filter')
subplot(211),imagesc(h),colormap('gray'),title('blurring filter mask')