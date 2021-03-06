const NUMBER_ROOM_PER_LOAD = 10;
const NUMBER_MESSAGE_PER_LOAD = 10;
const NUMBER_ACTIVE_UER_PER_LOAD = 10;

const MAX_FILE_NUMBER_RECEIVE = 2;
const MAX_FILE_SIZE_RECEIVE = 1024 * 1024 * 2 // 2MB

const INVALID_INPUT_MESSAGE='Invalid input';

const ROOM_UPLOAD_DIR = 'public/room/';
const CHAT_UPLOAD_DIR = 'public/message/';
const USER_UPLOAD_DIR = 'public/user/';

const ERROR_CODE = {
    FILE: 'FILE_INPUT_ERROR',
    ACCESS_DENIED: 'ACCESS_DENIED',
    USER_NOT_EXISTS: 'USER_NOT_EXISTS',
    ROOM_NOT_EXISTS: 'ROOM_NOT_EXISTS',
    CHAT_NOT_EXISTS: 'CHAT_NOT_EXISTS',
};

export {
    NUMBER_ROOM_PER_LOAD,
    NUMBER_MESSAGE_PER_LOAD,
    NUMBER_ACTIVE_UER_PER_LOAD,
    INVALID_INPUT_MESSAGE,
    ROOM_UPLOAD_DIR,
    CHAT_UPLOAD_DIR,
    USER_UPLOAD_DIR,
    MAX_FILE_NUMBER_RECEIVE,
    MAX_FILE_SIZE_RECEIVE,
    ERROR_CODE
};
