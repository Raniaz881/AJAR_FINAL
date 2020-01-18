const functions = require('firebase-functions')
const admin = require('firebase-admin')
admin.initializeApp()

exports.sendNotification = functions.firestore
  .document('messages/{groupId1}/{groupId2}/{message}')
  .onCreate((snap, context) => {
    console.log('----------------start function--------------------')

    const doc = snap.data()
    console.log(doc)

    const idFrom = doc.idFrom
    const idTo = doc.idTo
    const contentMessage = doc.content
    console.log(idTo)
    console.log(idFrom)
    // Get push token user to (receive)
    admin
      .firestore()
      .collection('users')
      .where('id', '==', idTo)
      .get()
      .then(querySnapshot => {
        querySnapshot.forEach(userTo => {
          console.log('Hello i am idTo')
          console.log(`Found user to: ${userTo.data().nickname}`)
          console.log(`Found user to: ${userTo.data().chattingWith}`)
          console.log(`Found user to: ${userTo.data().pushToken}`)

          console.log(userTo.data().pushToken && userTo.data().chattingWith !== idFrom)

          if (true) {
            // Get info user from (sent)
            admin
              .firestore()
              .collection('users')
              .where('id', '==', idFrom)
              .get()
              .then(querySnapshot2 => {
                querySnapshot2.forEach(userFrom => {
                  console.log(`Found user from: ${userFrom.data().nickname}`)
                  const payload = {
                    notification: {
                      title: `You have a message from "${userFrom.data().nickname}"`,
                      body: contentMessage,
                      badge: '1',
                      sound: 'default'
                    }
                  }
                  // Let push to the target device
                  admin
                    .messaging()
                    .sendToDevice(userTo.data().pushToken, payload)
                    .then(response => {
                      console.log('Successfully sent message:', response)
                    })
                    .catch(error => {
                      console.log('Error sending message:', error)
                    })
                })
              })
          } else {
            console.log('Can not find pushToken target user')
          }
        })
      })
    return null
  })


exports.sendRequestNotification = functions.firestore
  .document('users/{user}/requests/{id}')
  .onCreate((snap, context) => {
    console.log('----------------start function--------------------')

    const doc = snap.data()
    console.log(doc)

    const idFrom = doc.requestByID
    const idTo = doc.requestToID
//    const contentMessage = doc.content
//    console.log(idTo)
//    console.log(idFrom)
    // Get push token user to (receive)
    admin
      .firestore()
      .collection('users')
      .where('id', '==', idTo)
      .get()
      .then(querySnapshot => {
        querySnapshot.forEach(userTo => {
          console.log('Hello i am idTo')
          console.log(`Found user to: ${userTo.data().nickname}`)
//          console.log(`Found user to: ${userTo.data().chattingWith}`)
          console.log(`Found user to: ${userTo.data().pushToken}`)

          //console.log(userTo.data().pushToken && userTo.data().chattingWith !== idFrom)

          if (true) {
            // Get info user from (sent)
            admin
              .firestore()
              .collection('users')
              .where('id', '==', idFrom)
              .get()
              .then(querySnapshot2 => {
                querySnapshot2.forEach(userFrom => {
                  console.log(`Found user from: ${userFrom.data().nickname}`)
                  const payload = {
                    notification: {
                      title: `You have a request from "${userFrom.data().nickname}"`,
                      body:  `"${userFrom.data().nickname}" wants to connects to you`,
                      badge: '1',
                      sound: 'default'
                    }
                  }
                  // Let push to the target device
                  admin
                    .messaging()
                    .sendToDevice(userTo.data().pushToken, payload)
                    .then(response => {
                      console.log('Successfully sent message:', response)
                    })
                    .catch(error => {
                      console.log('Error sending message:', error)
                    })
                })
              })
          } else {
            console.log('Can not find pushToken target user')
          }
        })
      })
    return null
  })


exports.sendfriendNotification = functions.firestore
  .document('users/{user}/friends/{id}')
  .onCreate((snap, context) => {
    console.log('----------------start function--------------------')

    const doc = snap.data()
    console.log(doc)

    const idFrom = doc.myID
    const idTo = doc.friendID
//    const contentMessage = doc.content
//    console.log(idTo)
//    console.log(idFrom)
    // Get push token user to (receive)
    admin
      .firestore()
      .collection('users')
      .where('id', '==', idTo)
      .get()
      .then(querySnapshot => {
        querySnapshot.forEach(userTo => {
          console.log('Hello i am idTo')
          console.log(`Found user to: ${userTo.data().nickname}`)
//          console.log(`Found user to: ${userTo.data().chattingWith}`)
          console.log(`Found user to: ${userTo.data().pushToken}`)

          //console.log(userTo.data().pushToken && userTo.data().chattingWith !== idFrom)

          if (true) {
            // Get info user from (sent)
            admin
              .firestore()
              .collection('users')
              .where('id', '==', idFrom)
              .get()
              .then(querySnapshot2 => {
                querySnapshot2.forEach(userFrom => {
                  console.log(`Found user from: ${userFrom.data().nickname}`)
                  const payload = {
                    notification: {
                      title: `You are now friends "${userFrom.data().nickname}"`,
                      body:  `"${userFrom.data().nickname}" is your friend`,
                      badge: '1',
                      sound: 'default'
                    }
                  }
                  // Let push to the target device
                  admin
                    .messaging()
                    .sendToDevice(userTo.data().pushToken, payload)
                    .then(response => {
                      console.log('Successfully sent message:', response)
                    })
                    .catch(error => {
                      console.log('Error sending message:', error)
                    })
                })
              })
          } else {
            console.log('Can not find pushToken target user')
          }
        })
      })
    return null
  })