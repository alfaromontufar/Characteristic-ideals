n = 9;
-- lo anterior es el Parametro de entrada

-- Cosas a checar:
-- + n
-- + direccion
-- + matriz


loadPackage "NautyGraphs"
R = ZZ[t]; -- ZZ para coeficientes en Enteros; QQ para coeficientes en racionales

-- Codigo
L = generateGraphs(n, OnlyConnected => true);
fout = openOut toString(horizontalJoin("/Users/carlosalfaro/Documents/char ideals/DistanceZ/",toString(n),".txt"));

for s in L do (
    -- El numero de t's en la diagonal debe ser igual a n
    G = stringToGraph s;
    d = {};
    for i from 1 to n do(
	d = d|{t};
	);
    -- characteristic ideals
    --M = diagonalMatrix(d) - G.adjacencyMatrix;
    
    -- Laplacian characteristic ideals
    --M = diagonalMatrix(d) - laplacianMatrix G;
    
    -- distance characteristic ideals
    M = diagonalMatrix(d) - distanceMatrix G;
    
    -- distance Laplacian characteristic ideals
    --dist = distanceMatrix G;
    --transmition = {};
    --for i from 0 to n - 1 do (
	--tr = 0;
	--for j from 0 to n - 1 do (
	    --tr = tr + dist_(i,j);
	    --);
	--transmition = transmition|{tr};
	--);
    --M = diagonalMatrix(d) + diagonalMatrix(transmition) - dist;
    
    Bandera = 0; -- 0, si no se tiene gamma; 1, si ya 
    for i from 1 to n do(
	-- Conviene solo calcular los menores sin calcular la base de G, quizas ya este el 1 por ahí
	I = minors(i,M);
	
	if Bandera == 0 then (
	    k = 0;
	    for j from 0 to length(I_*)-1 do (
		if I_j == 1_R or I_j == -1_R then (
		    k = 1;
		    break
		    )
	        );
	    if k == 0 then (
		J = gens gb I;
		if J_0_0 == 1_R or J_0_0 == -1_R then (
		    ) else (
		    gamma = i - 1; -- gamma
		    Bandera = 1;
		    fout << s << " " << gamma << " " << substring(toString(J),7);
		    if i < n then (
			fout << " ";
			) else (
			fout << "\n";
			);
		    )
		)
	    ) else (
	    J = gens gb I;
	    fout << substring(toString(J),7);
	    if i < n then (
		fout << " ";
		) else (
		fout << "\n";
		)
	    )
	);
    print s;
    )
fout << close;
