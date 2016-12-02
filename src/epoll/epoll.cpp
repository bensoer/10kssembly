
#include <sys/socket.h>
#include <arpa/inet.h>
#include <algorithm>
#include <sys/epoll.h>
#include <assert.h>
#include <fcntl.h>

#include <stdio.h>
#include <iostream>
#include <sys/socket.h>
#include <netinet/in.h>
#include <string>
#include <unistd.h>
#include <vector>

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
#include <signal.h>
#include <vector>
#include <algorithm>
#include <fstream>

using namespace std;


/**
* main entrance to application. Creates a minimalistic epoll server with no error checking
* or handling. Designed for reverse compiling into assembly.
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

	//configure epoll queue length to 10
	const int EPOLL_QUEUE_LENGTH = 10;

	//configure epoll event objects
	struct epoll_event events[EPOLL_QUEUE_LENGTH];
	struct epoll_event event;
	//create epoll
	int epollDescriptor = epoll_create(EPOLL_QUEUE_LENGTH);
	//configure epoll - add listening socket to epoll
	event.events = EPOLLIN | EPOLLERR | EPOLLHUP | EPOLLET;
	event.data.fd = sfd;
	epoll_ctl(epollDescriptor, EPOLL_CTL_ADD, sfd, &event);

	//infinite loop
	while(1){
		//wait on epoll
		//printf("Waiting On Epoll \n");
		int num_fds = epoll_wait(epollDescriptor, events, EPOLL_QUEUE_LENGTH, -1);
		//loop through epoll results
		//printf("Epoll Event Occurred\n");
		for(int i = 0; i < num_fds; i++){

			//some kind of strange error has occurred - close the socket
			if (events[i].events & (EPOLLHUP | EPOLLERR)) {
				//printf("Error");
				close(events[i].data.fd);
			}

			//the event is to the listening socket, accept the conneciton and add to epoll
			if (events[i].data.fd == sfd) {
				//printf("New Connection\n");
				struct sockaddr_in client;

                socklen_t client_len = sizeof(client);
                int socketSessionDescriptor = accept(events[i].data.fd, (struct sockaddr *) &client,&client_len);

				fcntl(socketSessionDescriptor, F_SETFL, O_NONBLOCK | fcntl(socketSessionDescriptor, F_GETFL, 0));

				event.data.fd = socketSessionDescriptor;

				epoll_ctl(epollDescriptor, EPOLL_CTL_ADD, socketSessionDescriptor, &event);
			}else{
				//else this is a normal socket - read it and write it back
				//printf("New Message\n");
				//read and write it
				char BUFFER[1024];
				memset(BUFFER, '\0', 1024);

				long bytesRead = read(events[i].data.fd, BUFFER, 1024);

				write(events[i].data.fd, BUFFER, bytesRead);


			}


		}

	}
	




}