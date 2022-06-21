NB = 4

print("/** auto-generated code **/")
print()

print("/* Fill the matrix rowwise/colwise by blocks at the same time, starting at the diagonal entry i */")
print("size_t i = 0;")
print(f"while(i + {NB} - 1 < n_phi)")
print("{")

for i in range(NB):
    print(f"size_t i{i} = i + {i};")
print()

for i in range(NB):
    print(f"size_t cache_idx_row_i{i} = i{i} * (i{i} - 1) / 2;")
print()



print("/* Fill in the corresponding blocks in the upper and lower triangle")
print(" - these blocks are transposed of each other.")
print(f" - i is a multiple of {NB}")
print(" - block on diagonal is special case")
print("*/")
print(f"for (size_t j = 0 ; j < i ;  j+={NB})")
print("{")
for j in range(NB):
    print(f"size_t j{j} = j + {j};")
print()
print("// load cached values")
for i in range(NB):
    for j in range(NB):
        print(f"double phi_{i}_{j} = phi_cache[cache_idx_row_i{i} + j{j}];")

print()
print("// fill block in lower triangle")
for i in range(NB):
    for j in range(NB):
        print(f"A[i{i} * n_A + j{j}] = phi_{i}_{j};")
print()
print("// fill block in upper triangle")
for j in range(NB):
    for i in range(NB):
        print(f"A[j{j} * n_A+ i{i}] = phi_{i}_{j};")
print()
print("}")


print("/* The last block (j = i) is on the diagonal, it is symmetric with a zero diagonal. */")

print("{")

for j in range(NB):
    print(f"size_t j{j} = i + {j};")

for i in range(NB):
    for j in range(i):
        print(f"double phi_{i}_{j} = phi_cache[cache_idx_row_i{i} + j{j}];")
print()
print()
for i in range(NB):
    for j in range(NB):
        if i > j:
            print(f"A[i{i} * n_A + j{j}] = phi_{i}_{j};")
        elif i == j:
            print(f"A[i{i} * n_A + j{j}] = 0.;")
        else:
            print(f"A[i{i} * n_A + j{j}] = phi_{j}_{i};")
    print()
        

print("}")



print(f"i += {NB};")
print("}")

print()
print()
print("/* finish the rows and the columns */")

print("while (i < n_phi)")
print("{")

print("size_t cache_idx_row_i = i * (i - 1) / 2;")

print()
print("size_t j = 0;")
print(f"while(j + {NB} - 1 < i)")
print("{")

for j in range(NB):
    print(f"size_t j{j} = j + {j};")

for j in range(NB):
      print(f"double phi_i_{j} = phi_cache[cache_idx_row_i  + j{j}];")


print()
print("// fill line in lower triangle")
for j in range(NB):
    print(f"A[i * n_A + j{j}] = phi_i_{j};")
print()
print("// fill line in upper triangle")
for j in range(NB):
    print(f"A[j{j} * n_A+ i] = phi_i_{j};")

print(f"j += {NB};")

print("}")
print("while (j < i)")
print("{")

print(f"double phi_i_j = phi_cache[cache_idx_row_i + j];")
print(f"A[i * n_A + j] = phi_i_j;")
print(f"A[j * n_A+ i] = phi_i_j;")

print("j++;")
print("}")
print()
print("A[i * n_A + i] = 0.;")
print()
print("i++;")
print()
print("}")
print("/** end of auto-generated code **/")
