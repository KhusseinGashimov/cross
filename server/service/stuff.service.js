const {db} = require('../config/db');

const stuffTable = db.collection('stuff');
const logger = require('../logger/logger.config');

const getStuffOfMember = async (memberId) => {
    const snapshot =  await stuffTable.doc(memberId).get();
    return snapshot.data();
}

const getAllMembers = async () => {
    const snapshot = await stuffTable.get();
    return snapshot.docs.map(doc => ({
        id: doc.id,
        ...doc.data()
    }));
}

const createStuffMember = async (name,image, description) =>{
    const newStuff = {
        name: name,
        image: image,
        description: description
    }
    const ref = await stuffTable.add(newStuff);
    return ref.id;
}

const updateStuffMember = async (id,name,image,description) =>{
    const newStuff = {
        name: name,
        image: image,
        description: description
    }
    logger.info('Updating stuff member with id: ' + id);
    await stuffTable.doc(id).update(newStuff);
}

const deleteStuffMember = async (id) =>{
    await stuffTable.doc(id).delete();
}


module.exports = { getStuffOfMember, getAllMembers, createStuffMember, updateStuffMember, deleteStuffMember};