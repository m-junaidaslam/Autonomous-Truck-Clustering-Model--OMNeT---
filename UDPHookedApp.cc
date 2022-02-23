/*
 * UDPHookedApp.cc
 *
 *  Created on: 19/07/2018
 *      Author: andrewtorres
 */
#include <UDPHookedApp.h>
#include <iostream>
#include <string>

Define_Module(UDPHookedApp);

void UDPHookedApp::processPacket(cPacket *pkt) {

    simtime_t pktdelay = 0;
    pktdelay = simTime() - (pkt->getCreationTime());

    if (pktdelay > 0.15) {
        LostPkt++;
        WATCH(LostPkt);
        lostpkt_avgdelay = lostpkt_avgdelay +pktdelay;
        WATCH(lostpkt_avgdelay);
        delete pkt;
        return;
    } else {
        UDPBasicApp::processPacket(pkt);
    }
}

void UDPHookedApp::finish() {

    recordScalar("lost packets (due delay)", LostPkt);
    double avg_dly_lst = lostpkt_avgdelay.dbl()/LostPkt;
    recordScalar("packets avg_delays", avg_dly_lst);

    UDPBasicApp::finish();
}



