/*
 * UDPHookedApp.h
 *
 *  Created on: 19/07/2018
 *      Author: andrewtorres
 */

#ifndef UDPHOOKEDAPP_H_
#define UDPHOOKEDAPP_H_
#include <string.h>
#include <list>
#include "inet/common/INETDefs.h"
#include "inet/applications/udpapp/UDPBasicApp.h"
//#include "inet/networklayer/common/InterfaceTable.h"//InterfaceTableAccess.h
#include "inet/common/lifecycle/NodeOperations.h"

class UDPHookedApp: public inet::UDPBasicApp {

private:
    simtime_t lostpkt_avgdelay;
    int LostPkt;

protected:
    virtual void processPacket(cPacket *pk);
    virtual void finish();
};


#endif /* UDPHOOKEDAPP_H_ */
