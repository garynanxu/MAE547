function EulerAngles()
disp('Do you have Euler Angles and You want to Find the Corresponding Rotation Matrix? Y/N')
A=input('','s');

if A== 'Y' || A== 'y'
    
    disp('Enter the Angle Phi in degrees:')
    phi=input('');
    disp('Enter the Angle Theta in degrees:')
    theta=input('');
    disp('Enter the Angle Psi in degrees:')
    psi=input('');
    disp('Enter the Euler sequence notation, ZYZ, XYZ, .. etc:')
    config=input('','s');
    
    if (config=='ZYZ') or (config=='zyz')
        RotEul=eul2r(phi,theta,psi,'deg')
    else
        RotEul=rpy2r(phi,theta,psi,config,'deg')
    end
    assignin('base','RotEul',RotEul)
else
    disp('Do you have a rotation matrix and you want to find the corresponding Euler Angles? Y/N')
    B=input('','s');
    if B== 'Y' || B=='y'
        disp('Enter the Euler sequence notation, ZYZ, XYZ, .. etc:')
        config=input('','s');
        disp('Please Insert Your Rotation Matrix:')
        R=input('');
        Angles=rotm2eul(R,config,'deg');
        phiEul=Angles(1)*(180/pi)
        assignin('base','phiEul',phiEul)
        thetaEul=Angles(2)*(180/pi)
        assignin('base','thetaEul',thetaEul)
        psiEul=Angles(3)*(180/pi)
        assignin('base','psiEul',psiEul)
    end
end
end