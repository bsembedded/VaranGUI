#include "udpsendtogen.h"


UdpSendToGen::UdpSendToGen(QObject *parent) : QObject(parent)
{

    for (int i = 0; i < 274; i++) state900[i] = 0;
    // create a QUDP socket
    udpSocket = new QUdpSocket(this);

    // The most common way to use QUdpSocket class is
    // to bind to an address and port using bind()
    // bool QAbstractSocket::bind(const QHost Address & address,
    //      quint16 port = 0, BindMode = DefaultForPlatform)
    udpSocket->bind(QHostAddress("192.168.3.1"), 25000);
    //socket->bind(QHostAddress("192.168.159.2"), 8785);

    connect(udpSocket, SIGNAL(readyRead()), this, SLOT(readyRead()));

}


void UdpSendToGen::cppSlot900(const QVariant &v) {

    int j = 0;

    qDebug() << "Called the C++ slot with value:" << v;
    QList<QVariant> item = v.toList();

    for (int i = 0; i < 274; i++) state900[i] = 0;

    for (int i = 0; i < 174; i++) {
        if(item[i].toBool()) {
            if (i < 125) state900[j] = 890 + 0.2 * i + 45 - 952.5;
            else state900[j] = 890 + 0.2 * (i + 850 - 1024) + 45 - 952.5;
            state900[j] *= 1000;
            j++;
        }
    }

    QByteArray toSend = QByteArray::fromRawData(reinterpret_cast<const char*>(state900), sizeof(state900));
    udpSocket->writeDatagram(toSend, QHostAddress("192.168.3.2"), 25002);

}

void UdpSendToGen::cppSlot1800(const QVariant &v) {

    int j = 0;

    qDebug() << "Called the C++ slot with value:" << v;
    QList<QVariant> item = v.toList();

    for (int i = 0; i < 274; i++) state1800[i] = 0;

    for (int i = 0; i < 274; i++) {
        if(item[i].toBool()) {
            state1800[j] = 1710.2 + 0.2 * (i + 612 - 512) + 95 - 952.5 - 900;
            state1800[j] *= 1000;
            j++;
        }
    }

    QByteArray toSend = QByteArray::fromRawData(reinterpret_cast<const char*>(state1800), sizeof(state1800));
    udpSocket->writeDatagram(toSend, QHostAddress("192.168.3.2"), 25001);



}

void UdpSendToGen::cppSlotPar(const QVariant &v) {

    qDebug() << "Called the C++ slot with value:" << v;
    QList<QVariant> item = v.toList();

    for (int i = 0; i < 7; i++) stateParam[i] = item[i].toDouble();



    QByteArray toSend = QByteArray::fromRawData(reinterpret_cast<const char*>(stateParam), sizeof(stateParam));
    udpSocket->writeDatagram(toSend, QHostAddress("192.168.3.2"), 25000);



}

void UdpSendToGen::readyRead()
{
    // when data comes in
    //QByteArray buffer;
    //buffer.resize(socket->pendingDatagramSize());

    //QHostAddress sender;
    //quint16 senderPort;

    // qint64 QUdpSocket::readDatagram(char * data, qint64 maxSize,
    //                  QHostAddress * address = 0, quint16 * port = 0)
    // Receives a datagram no larger than maxSize bytes and stores it in data.
    // The sender's host address and port is stored in *address and *port
    // (unless the pointers are 0).

    //socket->readDatagram(buffer.data(), buffer.size(),
    //                     &sender, &senderPort);

    while(udpSocket->hasPendingDatagrams())
    {
        QNetworkDatagram datagram = udpSocket->receiveDatagram();

        QByteArray tmp = datagram.data();

        QVector<double> data;
        QDataStream stream(tmp);
        stream >> data;

        qDebug() << "Message: " << data;
    }

}
