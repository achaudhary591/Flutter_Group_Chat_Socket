const io = require('socket.io')(3000);

io.on('connection', (socket) => {
  console.log('a user connected');

  socket.on('new message', (msg) => {
    io.emit('new message', msg);
  });

  socket.on('disconnect', () => {
    console.log('user disconnected');
  });
});

