% q = x(:,N_Q); q' = x(:,N_V); 
% Npl(3)   Npl(4)   flexor-extensor velocities
% plot pendulum in polar coordinates.

nf = nf+1;

figure(nf),

q = x(t0*10+1:time_max*10,N_Q)-pi/2;
vq = 100*x(t0*10+1:time_max*10,N_V);
mn_flx = x(t0*10+1:time_max*10,N_V+N_MnF);
mn_ext = x(t0*10+1:time_max*10,N_V+N_MnE);

r = sqrt( vq.*vq+q.*q );
phi = atan2( vq, q);
[maxy, maxi] = max(phi);

found = 0;
for( i = maxi-2:-1:1 )
    if( phi(i+1 )- phi( i ) > 0 )
        found = 1;
        break;
    end
end
mini = i;
if( found ~= 1 )
    mini = maxi;
    for( i = mini+1:1:length( phi )-1 )
        if( phi(i+1 )- phi( i ) > 0 )
            found = 1;
            break;
        end
    end
    maxi = i;
end

[mv, mvi] = max(vq(mini+1:maxi-1));
if( length( mvi ) > 1 )
    maxvi = mvi( length( mvi )/2);
    maxv = mv( length( mvi )/2 );
else
    maxvi = mvi;
    maxv = mv;
end
r3_ext = r( mini+1+maxvi );
phi3_ext = phi( mini+1+maxvi );

[mv, mvi] = min(vq(mini+1:maxi-1));
if( length( mvi ) > 1 )
    minvi = mvi( length( mvi )/2);
    minv = mv( length( mvi )/2 );
else
    minvi = mvi;
    minv = mv;
end
r3_flx = r( mini+1+minvi );
phi3_flx = phi( mini+1+minvi );


flx_on = -1; ext_on = -1;
r1_flx = 0; r1_ext = 0;
phi1_flx = 0; phi1_ext = 0;
max_flx = max( mn_flx(mini+1:maxi-1));
for( i = mini+1:1:maxi-1 )
    if( mn_flx(i) < max_flx && flx_on == -1 )
        flx_on = i;
    end
    if( flx_on ~= -1 && mn_flx(i) >= max_flx )
        flx_on = i;
        r1_flx = r( flx_on );
        phi1_flx = phi( flx_on );
        break;
    end
end
max_ext = max( mn_ext(mini+1:maxi-1));
for( i = mini+1:1:maxi-1 )
    if( mn_ext(i) < max_ext && ext_on == -1 )
        ext_on = i;
    end
    if( ext_on ~= -1 && mn_ext(i) >= max_ext )
        ext_on = i;
        r1_ext = r( ext_on );
        phi1_ext = phi( ext_on );
        break;
    end
end

%phase transition
flx_thr = 0.3*max_ext;
eps = 0.0;
flx_on1 = flx_on;
for( i = flx_on:-1:mini+1 )
    if( mn_ext(i) > flx_thr )
        if( mn_ext(i-1)-mn_ext(i) < 0.1*eps )
            flx_on1 = i;
            flx_thr = mn_ext( flx_on1 );
            break;
        end
    else
        if( mn_ext(i-1)-mn_ext(i) > eps )
            eps = mn_ext(i-1)-mn_ext(i);
        end
    end
end
r2_flx = r( flx_on1 );
phi2_flx = phi( flx_on1 );

[r4_flx,i] = max( r( flx_on1:flx_on ));
phi4_flx = phi( i+flx_on1 );

ext_thr = 0.3*max_flx;
eps = 0.0;
ext_on1 = ext_on;
for( i = ext_on:-1:mini+1 )
    if( mn_flx(i) > ext_thr )
        if( mn_flx(i-1)-mn_flx(i) < 0.2*eps )
            ext_on1 = i;
            ext_thr = mn_flx( ext_on1 );
            break;
        end
    else
        if( mn_flx(i-1)-mn_flx(i) > eps )
            eps = mn_flx(i-1)-mn_flx(i);
        end
    end
end
r2_ext = r( ext_on1 );
phi2_ext = phi( ext_on1 );
[r4_ext,i] = max( r( ext_on1:ext_on ));
phi4_ext = phi( i+ext_on1 );

% fl = r( flx_on1:flx_on );
% diff_rfl = diff( r( flx_on1:flx_on ));
% diff_phifl = diff( phi( flx_on1:flx_on ));
% diff_fl = diff_rfl;%./diff_phifl;
% diff_rfl1 = diff( diff_rfl );
% diff_fl1 = diff_rfl1;%./diff_phifl(2:end);
% [~,b] = min( diff_fl1 );
% r5_flx = r( flx_on1+b );
% phi5_flx = phi( flx_on1+b );
% 
% ex = r( ext_on1:ext_on );
% diff_rex = diff( r( ext_on1:ext_on ));
% diff_phiex = diff( phi( ext_on1:ext_on ));
% diff_ex = diff_rex;%./diff_phiex;
% diff_rex1 = diff( diff_rex );
% diff_ex1 = diff_rex1;%./diff_phiex(2:end);
% [~,b] = min( diff_ex1 );
% r5_ext = r( ext_on1+b );
% phi5_ext = phi( ext_on1+b );


r1 = r(mini+1:maxi-1);
phi1 = phi(mini+1:maxi-1);
polar( phi1, r1,'b-');
hold on;
polar( phi1_flx, r1_flx,'r*');
hold on;
polar( phi2_flx, r2_flx,'r*');
hold on;
polar( phi4_flx, r4_flx,'g*');
hold on;
polar( phi3_flx, r3_flx,'k+');
hold on;
% polar( phi5_flx, r5_flx,'m*');

hold on;
polar( phi1_ext, r1_ext,'c*');
hold on;
polar( phi2_ext, r2_ext,'c*');
hold on;
polar( phi4_ext, r4_ext,'g*');
hold on;
polar( phi3_ext, r3_ext,'k+');
hold on;
% polar( phi5_ext, r5_ext,'m*');
hold on;
title('Angle versus pendulum velocity');

nf = nf+1;
figure(nf),
plot( phi1, r1, 'b-', 'LineWidth', 1. );
hold on;
plot( phi1_flx, r1_flx, 'r*','LineWidth', 5. );
hold on;
plot( phi2_flx, r2_flx, 'r*','LineWidth', 5. );
hold on;
plot( phi4_flx, r4_flx, 'g*','LineWidth', 3. );
hold on;
plot( phi3_flx, r3_flx, 'k+','LineWidth', 5. );
hold on;
% plot( phi5_flx, r5_flx, 'm*','LineWidth', 5. );
hold on;

plot( phi1_ext, r1_ext, 'c*','LineWidth', 5. );
hold on;
plot( phi2_ext, r2_ext, 'c*','LineWidth', 5. );
hold on;
plot( phi4_ext, r4_ext, 'g*','LineWidth', 5. );
hold on;
plot( phi3_ext, r3_ext, 'k+','LineWidth', 3. );
hold on;
% plot( phi5_ext, r5_ext, 'm*','LineWidth', 5. );
hold on;
title('Angle versus pendulum velocity');


% nf = nf+1;
% figure(nf),
% plot( diff_fl1, 'g-', 'LineWidth', 1. );
% hold on;
% plot( fl, 'k-', 'LineWidth', 1. );
% hold on;
% plot( diff_fl, 'r-', 'LineWidth', 1. );
% hold on;

nf = nf+1;
figure(nf),

plot( 1:length(mn_ext), mn_ext, 'g-', 'LineWidth', 1. );
hold on;
plot( 1:length(mn_flx), mn_flx, 'b-', 'LineWidth', 1. );
hold on;
plot( flx_on, max_flx, 'r*', 'LineWidth', 5. );
hold on;
plot( flx_on1, flx_thr, 'r*', 'LineWidth', 5. );
hold on;
plot( ext_on, max_ext, 'c*', 'LineWidth', 5. );
hold on;
plot( ext_on1, ext_thr, 'c*', 'LineWidth', 5. );
hold on;
title('Mn flexors & extensors');

nf = 0;

