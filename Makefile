SERVICIO = calc
IDL      = idl/$(SERVICIO).x
GEN      = gen

CC     = gcc
CFLAGS = -g -I$(GEN) -I/usr/include/tirpc
LDLIBS = -ltirpc

GEN_H    = $(GEN)/$(SERVICIO).h
GEN_XDR  = $(GEN)/$(SERVICIO)_xdr.c
GEN_CLNT = $(GEN)/$(SERVICIO)_clnt.c
GEN_SVC  = $(GEN)/$(SERVICIO)_svc.c

all: bin/servidor bin/cliente

$(GEN_H) $(GEN_XDR) $(GEN_CLNT) $(GEN_SVC): $(IDL)
	mkdir -p $(GEN)
	cp $(IDL) $(GEN)/
	cd $(GEN) && rpcgen -C $(SERVICIO).x && rm -f $(SERVICIO).x

bin/servidor: $(GEN_SVC) $(GEN_XDR) $(GEN_H) servidor/$(SERVICIO)_server.c
	mkdir -p bin
	$(CC) $(CFLAGS) -o $@ $(GEN_SVC) $(GEN_XDR) servidor/$(SERVICIO)_server.c $(LDLIBS)

bin/cliente: $(GEN_CLNT) $(GEN_XDR) $(GEN_H) cliente/$(SERVICIO)_client.c
	mkdir -p bin
	$(CC) $(CFLAGS) -o $@ $(GEN_CLNT) $(GEN_XDR) cliente/$(SERVICIO)_client.c $(LDLIBS)

clean:
	rm -rf bin $(GEN)

.PHONY: all clean
