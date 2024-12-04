FROM ghcr.io/ponylang/ponyc:alpine AS build

WORKDIR /src/ponydoc

COPY Makefile LICENSE VERSION /src/ponydoc/

WORKDIR /src/ponydoc/ponydoc

COPY ponydoc /src/ponydoc/ponydoc/

WORKDIR /src/ponydoc

RUN make arch=x86-64 static=true linker=bfd \
 && make install

FROM alpine:3.20

COPY --from=build /usr/local/bin/ponydoc /usr/local/bin/ponydoc

CMD ponydoc
