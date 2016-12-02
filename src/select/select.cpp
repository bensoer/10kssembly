
#include <stdio.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <stdlib.h>
#include <string>
#include <string.h>
#include <arpa/inet.h>
#include <unistd.h>
#include <iostream>
#include <netdb.h>

#include <netinet/in.h>
#include <string>
#include <unistd.h>
#include <bits/signum.h>
#include <signal.h>
#include <vector>
#include <algorithm>
#include <sys/epoll.h>
#include <fstream>

using namespace std;

/**
* Main entrance to a select server with no error checking or handling. Designed to be reverse compiled into assembly
**/
int main(){
	//create the socket
	int sfd = socket(AF_INET, SOCK_STREAM, 0);

	struct	sockaddr_in server;
    //bind the socket
    bzero((char *)&server, sizeof(struct sockaddr_in));
    server.sin_family = AF_INET;
    server.sin_port = htons(8000);
    server.sin_addr.s_addr = htonl(INADDR_ANY);

    bind(sfd, (struct sockaddr *)&(server), sizeof(server));
	
	//listen for connections. max queue size of 10	
	listen(sfd, 10);


	int clients[FD_SETSIZE];
	int highestFileDescriptor = sfd;
	int highestClientIndex = 0;
	fd_set rset, allset;
    FD_ZERO(&allset);
    FD_SET(sfd, &allset);

    //cleanup the clients
    for(unsigned int i = 0; i < FD_SETSIZE; i++){
        clients[i] = -1; //our setting to mean not in use
    }


    while(1){

    	//printf("Waiting On Select\n");
    	rset = allset;
        int nready = select(highestFileDescriptor + 1, &rset, NULL, NULL,NULL);
        //printf("Select is Back\n");
        if(FD_ISSET(sfd, &rset)){
        	//printf("New Connection\n");

        	sockaddr_in client;
        	socklen_t client_len= sizeof(client);
			int socketSessionDescriptor = accept(sfd, (struct sockaddr *)&client,&client_len);
            
            for(int i = 0; i < FD_SETSIZE; i++){
            	if(clients[i] < 0){
            		clients[i] = socketSessionDescriptor;

            		if(i > highestClientIndex){
            			highestClientIndex = i;
            		}

            		break;
            	}
            }

            FD_SET(socketSessionDescriptor, &allset);
            if(highestFileDescriptor < socketSessionDescriptor){
            	highestFileDescriptor = socketSessionDescriptor;
            }

            nready = nready - 1;

        }

        //check all socket descriptors for data
        for(int i = 0; i <= highestClientIndex; i++){

        	if(clients[i] < 0){
        		continue;
        	}

        	if(FD_ISSET(clients[i], &rset)){
        		//printf("New Read\n");
        		//this is a normal 	read and write

        		char BUFFER[1024];
				memset(BUFFER, '\0', 1024);

				long bytesRead = read(clients[i], BUFFER, 1024);

				write(clients[i], BUFFER, bytesRead);

				nready = nready - 1;

        	}
        }
    }
	




}