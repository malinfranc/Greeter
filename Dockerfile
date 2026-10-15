# ---- Etape 1 : "build"
# Parent image from debian distribution
FROM debian:stable-slim AS build
# Installer les outils C++ (une seule commande = une seule couche)
RUN apt-get update \
 && apt-get install -y --no-install-recommends cmake ninja-build g++ \
 && rm -rf /var/lib/apt/lists/*
# Copy source code in /src
WORKDIR /src
COPY . .
# Configurer, compiler, tester puis installer dans /install
RUN cmake -S . -B build -G Ninja -DCMAKE_BUILD_TYPE=Release \
 && cmake --build build \
 && ctest --test-dir build --output-on-failure \
 && cmake --install build --prefix 

 FROM debian:stable-slim
COPY --from=build /install/bin/HelloWorld /usr/local/bin/greet

CMD ["greet"]