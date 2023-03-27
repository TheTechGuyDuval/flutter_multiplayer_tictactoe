//importing modules
const Room = require('./models/room');
const express = require('express');
const http = require('http');
const mongoose = require('mongoose');
const app = express();
const port = process.env.PORT || 3000;
var server = http.createServer(app)
var io = require("socket.io")(server);

//client - middleware- server
//middleware

app.use(express.json());



io.on('connection', (socket) => {
    console.log('someone connected!');
    socket.on("createRoom", async ({ nickName }) => {
        try {
            console.log(nickName);
            //create room
            let room = new Room();
            //create player
            let player = {
                socketID: socket.id,
                nickName,
                playerType: 'X',
            };

            //    add player to room with defaul turn
            room.players.push(player);
            room.turn = player;
            room = await room.save();
            console.log(room);

            const roomId = room._id.toString();
            socket.join(roomId);
            //tell client that room is created
            //go to the next page
            io.to(roomId).emit('createRoomSuccess', room);
        }
        catch (e) {
            console.log(e);
        }





    });


    socket.on('joinRoom', async ({ nickName, roomId }) => {
        try {
            if (!roomId.match(/^[0-9a-fA-F]{24}$/)) {
                socket.emit('errorOccured', 'Please enter a valid room ID.');
                return;

            }
            let room = await Room.findById(roomId);

            if (room.isJoin) {
                let player = {
                    nickName,
                    socketID: socket.id,
                    playerType: 'O'
                }

                socket.join(roomId);
                room.players.push(player);
                room.isJoin = false;
                room = await room.save();
                io.to(roomId).emit('joinRoomSuccess', room);
                io.to(roomId).emit('updatePlayers', room.players);
                io.to(roomId).emit('updateRoom', room);

            } else {
                socket.emit('errorOccured', 'The game is in progress ,try again later.');

            }


        }
        catch (e) {
            console.log(e);
        }

    });


    socket.on('tap', async ({ index, roomId }) => {
        try {
            let room = await Room.findById((roomId));
            let choice = room.turn.playerType; //x/o
            if (room.turnIndex == 0) {
                room.turn = room.players[1];
                room.turnIndex = 1;

            }
            else {
                room.turn = room.players[0];
                room.turnIndex = 0;

            }
            room = await room.save();
            io.to(roomId).emit("tapped", {
                index,
                choice,
                room
            });

        }
        catch (e) {
            console.log(e);
        }

    });

    socket.on('winner', async ({ winnerSocketId, roomId }) => {
        try {
            let room = await Room.findById(roomId);

            let player = room.players.find((playerr) => playerr.socketID == winnerSocketId);

            player.points += 1;
            room = await room.save();

            if(player.points >= room.maxRounds){
                io.to(roomId).emit('endGame', player);
            }
            else{
                io.to(roomId).emit('increasePoint', player);
            }




        }
        catch (e) {
            console.log(e)
        }

    });

});


const DB = 'mongodb+srv://choupoduval:Chops123.@cluster0.8fp2ed2.mongodb.net/?retryWrites=true&w=majority';


mongoose.connect(DB).then(() => {
    console.log('Connection succesful!')
}).catch((e) => {
    console.log(e)
})





server.listen(port, "0.0.0.0", () => {
    console.log(`Server started and running on port ${port}`);


})
