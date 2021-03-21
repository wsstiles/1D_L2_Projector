function pde_struct = pde()
    pde_struct = struct();
    pde_struct.a = 0;
    pde_struct.b = 1;
    pde_struct.leftBC = 1;
    pde_struct.rightBC = 1;
    pde_struct.loadf = @f;
    pde_struct.exactu = @u;
    pde_struct.uprime = @uprime;
    pde_struct.upprime = @upprime;
end