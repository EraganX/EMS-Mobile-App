const { Schema, model } = require("mongoose");

const Address = Schema({
    province:{type:String},
    district:{type:String},
    // city:{type:String},
    // postal:{type:String},
});

const UserSchema = Schema({
    name: {
        type: String,
        required: true
    },
    email: {
        type: String,
        required: true,
        unique: true
    },
    git: {
        type: String,
        required: true,
        unique: true
    },
    role:{
        type:String,
        required : true,
    },
    password: {
        type: String,
        required: true,
    },
    online: {
        type: Boolean,
        default: false,
    },
    time: {
        type: String,
        default: new Date(),
    },
    address:{
        type:[Address],
    }
});

// extract only what we need to show
UserSchema.method('toJSON',function(){
    const { __v,_id, password, ...object} = this.toObject();
    object.uid = _id;
    //console.log(object)
    return object;
});


module.exports = model('User',UserSchema);