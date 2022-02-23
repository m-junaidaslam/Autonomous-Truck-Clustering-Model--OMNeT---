import inet.applications.udpapp.UDPBasicApp;

simple UDPHookedApp extends UDPBasicApp
{
    parameters:
        int numConnections=default(2);
    
    @class(UDPHookedApp);
        
}

