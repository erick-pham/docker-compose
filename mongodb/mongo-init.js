// db = (new Mongo('localhost:27017')).getDB('admin')
use admin
db.auth('root', 'password123')
db.grantRolesToUser(
    "root",
    [{
        role: "dbOwner",
        db: "b2cc"
    }], {
        w: "majority",
        wtimeout: 4000
    }
)

// db.createUser({
//     user: "root",
//     pwd: 'password123',
//     roles: [{
//         role: "readWrite",
//         db: "b2c"
//     }]
// })

db.createUser({
    user: 'erick',
    pwd: 'password123',
    roles: [{
        role: 'readWrite',
        db: 'b2c'
    }]
});