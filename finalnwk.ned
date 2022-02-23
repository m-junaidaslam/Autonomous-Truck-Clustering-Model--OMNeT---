import inet.networklayer.configurator.ipv4.IPv4NetworkConfigurator;
import inet.node.inet.Router;
import inet.node.inet.WirelessHost;
import inet.node.wireless.AccessPoint;
import inet.physicallayer.ieee80211.packetlevel.Ieee80211ScalarRadioMedium;
import inet.visualizer.integrated.IntegratedCanvasVisualizer;
import inet.node.inet.StandardHost;
import ned.DatarateChannel;



network Finalnwk
{
    @display("bgb=676,480");
    int num_trck = 2;

    types:
        channel AP2CH extends DatarateChannel
        {
            datarate = 100Mbps;
        }

        channel CH2HTTP extends DatarateChannel
        {
            datarate = 100Mbps;
            delay = exponential(30ms);
        }
        channel LTEconnection extends DatarateChannel
        {
            datarate = 8Mbps;
            delay = 10ms;
        }
        channel RL2UDP extends DatarateChannel
        {
            datarate = 100Mbps;
            delay = exponential(30ms);
        }
        channel RL2FTP extends DatarateChannel
        {
            datarate = 100Mbps;
            delay = 5ms;
        }

    submodules:

        radioMedium: Ieee80211ScalarRadioMedium {
            @display("p=601,71");
        }
        configurator: IPv4NetworkConfigurator {
            @display("p=602,21");
        }
        visualizer: IntegratedCanvasVisualizer {
            @display("p=602,122");
        }
        truck[num_trck]: WirelessHost {
            @display("p=249,369,c,50");
        }
        FTPtruck: WirelessHost {
            @display("p=316,325");
        }
        SensorCar: WirelessHost {
            @display("p=49,330");
        }
        routerCH: Router {
            @display("p=158,211");
        }
        routerLab: Router {
            @display("p=158,77");
        }
        headAP: AccessPoint {
            @display("p=158,324");
        }
        HTTPserver: StandardHost {
            @display("p=287,211");
        }
        FTPserver: StandardHost {
            @display("p=316,19");
        }
        UDPserver: StandardHost {
            @display("p=316,90");
        }
    connections:
        headAP.ethg++ <--> AP2CH <--> routerCH.ethg++; // clusterHead internal (AP to router)
        HTTPserver.ethg++ <--> CH2HTTP <--> routerCH.ethg++; // HTTP to router

        routerCH.pppg++ <--> LTEconnection <--> routerLab.pppg++; // between routers

        routerLab.ethg++ <--> RL2FTP <--> FTPserver.ethg++; // lab router to FTP
        routerLab.ethg++ <--> RL2UDP <--> UDPserver.ethg++; // lab router to UDP
}
