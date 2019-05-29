#ifndef UDPSENDTOGEN_H
#define UDPSENDTOGEN_H

#include <QObject>
#include <QQuickItem>
#include <QList>
#include <QUdpSocket>
#include <QNetworkDatagram>

class UdpSendToGen : public QObject
{
    Q_OBJECT
public:
    double state900[274];
    double state1800[274];
    double stateParam[7];
    //double fftRes[15*4096];
    explicit UdpSendToGen(QObject *parent = nullptr);

private:
    QUdpSocket *udpSocket;


signals:

public slots:
    void cppSlot900(const QVariant &v);
    void cppSlot1800(const QVariant &v);
    void cppSlotPar(const QVariant &v);
    void readyRead();
};


#endif // UDPSENDTOGEN_H
