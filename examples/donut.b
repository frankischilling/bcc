/* donut.b - Spinning ASCII donut animation
 * Based on a1k0n's donut algorithm
 * https://www.a1k0n.net/2021/01/13/optimizing-donut.html
 *
 * Adapted for the B programming language with fixed-point arithmetic.
 * Uses sx64() for 16-bit sign extension on 64-bit hosts.
 *
 * Run with: ./bcc examples/donut.b -o donut && ./donut
 * Press Ctrl+C to stop.
 */

b[2000];z[2000];A;B;C;D;E;F;G;H;I;J;
K;L;M;N;O;P;Q;R;S;T;U;V;W;X;Y;Z;

main() {
    A = C = 1024;
    B = D = 0;
    
    while (1) {
        /* Clear frame buffer */
        E = 0;
        while (E < 2000) {
            b[E] = 32;      /* space */
            z[E++] = 127;   /* z-buffer init */
        }
        
        /* Render torus */
        E = G = 0;
        F = 1024;
        while (G++ < 90) {
            H = I = 0;
            J = 1024;
            while (I++ < 324) {
                M = F + 2048;
                Z = J * M >> 10;
                P = B * E >> 10;
                Q = H * M >> 10;
                R = P - (A * Q >> 10);
                S = A * E >> 10;
                /* Perspective depth - scaled for 64-bit arithmetic */
                T = 5120 + S + sx64(B * Q >> 10);
                if (T < 1) T = 1;
                U = F * H >> 10;
                /* Screen coordinates */
                X = 40 + 30 * (sx64(D * Z >> 10) - sx64(C * R >> 10)) / T;
                Y = 12 + 15 * (sx64(D * R >> 10) + sx64(C * Z >> 10)) / T;
                /* Luminance */
                N = sx64((-B * U - D * ((-sx64(A * U) >> 10) + P) - J * (F * C >> 10) >> 10) - S >> 7);
                O = X + 80 * Y;
                V = sx64(T - 5120 >> 4);
                /* Z-buffer test and pixel write */
                if (22 > Y & Y > 0 & X > 0 & 80 > X & V < z[O]) {
                    z[O] = V;
                    b[O] = *(".,-~:;=!*#$@" + (N > 0 ? N : 0));
                }
                /* Inner torus rotation */
                L = J; J -= 5 * H >> 8; H += 5 * L >> 8;
                L = 3145728 - J * J - H * H >> 11;
                J = sx64(J * L >> 10);
                H = sx64(H * L >> 10);
            }
            /* Outer torus rotation */
            L = F; F -= 9 * E >> 7; E += 9 * L >> 7;
            L = 3145728 - F * F - E * E >> 11;
            F = sx64(F * L >> 10);
            E = sx64(E * L >> 10);
        }
        
        /* Output frame */
        K = -1;
        while (1761 > ++K) putchar(K % 80 ? b[K] : 10);
        
        /* Frame-to-frame rotation */
        L = B; B -= 5 * A >> 7; A += 5 * L >> 7;
        L = 3145728 - B * B - A * A >> 11;
        B = sx64(B * L >> 10);
        A = sx64(A * L >> 10);
        L = D; D -= 5 * C >> 8; C += 5 * L >> 8;
        L = 3145728 - D * D - C * C >> 11;
        D = sx64(D * L >> 10);
        C = sx64(C * L >> 10);
        
        /* Delay and cursor reset */
        usleep(30000);
        printf("%c[23A", 27);
    }
}

