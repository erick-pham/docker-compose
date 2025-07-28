const {
    MongoClient
} = require('mongodb');

async function listDatabases(client) {
    databasesList = await client.db().admin().listDatabases();

    console.log("Databases:");
    databasesList.databases.forEach(db => console.log(` - ${db.name}`));
};

async function main() {
    /**
     * Connection URI. Update <username>, <password>, and <your-cluster-url> to reflect your cluster.
     * See https://docs.mongodb.com/ecosystem/drivers/node/ for more details
     */
    const uri = "mongodb://dev:password123@localhost:27017/b2c?authSource=admin&w=majority&readPreference=primary&appname=MongoDB%20Compass&retryWrites=false&ssl=false";
    const client = new MongoClient(uri, {
        useUnifiedTopology: true,
        useNewUrlParser: true
    });


    /**
     * The Mongo Client you will use to interact with your database
     * See bit.ly/Node_MongoClient for more details
     */

    try {
        // Connect to the MongoDB cluster
        await client.connect();
        db = client.db('bc2')

        // await listDatabases(client)
        // await client.db('b2c').createCollection("studentss", {
        //     validator: {
        //         $jsonSchema: {
        //             bsonType: "object",
        //             required: ["name", "year", "major", "address"],
        //             properties: {
        //                 name: {
        //                     bsonType: "string",
        //                     description: "must be a string and is required"
        //                 },
        //                 year: {
        //                     bsonType: "int",
        //                     minimum: 2017,
        //                     maximum: 3017,
        //                     description: "must be an integer in [ 2017, 3017 ] and is required"
        //                 },
        //                 major: {
        //                     enum: ["Math", "English", "Computer Science", "History", null],
        //                     description: "can only be one of the enum values and is required"
        //                 },
        //                 gpa: {
        //                     bsonType: ["double"],
        //                     description: "must be a double if the field exists"
        //                 },
        //                 address: {
        //                     bsonType: "object",
        //                     required: ["city"],
        //                     properties: {
        //                         street: {
        //                             bsonType: "string",
        //                             description: "must be a string if the field exists"
        //                         },
        //                         city: {
        //                             bsonType: "string",
        //                             "description": "must be a string and is required"
        //                         }
        //                     }
        //                 }
        //             }
        //         }
        //     }
        // })
        // Make the appropriate DB calls
        // const session = client.startSession();
        // try {

        // const transactionOptions = {
        //     readPreference: 'primary',
        //     readConcern: {
        //         level: 'local'
        //     },
        //     writeConcern: {
        //         w: 'majority'
        //     }
        // };

        // const user = await client.db('b2c').collection('quotes');
        // const transactionResults = await session.withTransaction(async () => {
        //     const newUser1 = await user.insertOne({
        //         name: 'toàn',
        //         age: 4654
        //     }, {
        //         session
        //     })
        //     const newUser2 = await user.insertOne({
        //         name: 'toàn',
        //         age: 4654
        //     }, {
        //         session
        //     })
        //     console.log(newUser2.insertedId)
        //     console.log(newUser1.insertedId)
        // }, transactionOptions);

        // if (transactionResults) {
        //     console.log("The reservation was successfully created.");
        // } else {
        //     session.abortTransaction()
        //     console.log("The transaction was intentionally aborted.");
        // }
        // } catch (e) {
        //     console.log("The transaction was aborted due to an unexpected error: " + e);
        // } finally {
        //     // Step 4: End the session
        //     await session.endSession();
        // }

    } finally {
        // Close the connection to the MongoDB cluster
        await client.close();
    }
}

main().catch(console.error);