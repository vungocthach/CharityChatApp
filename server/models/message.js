import { DataTypes, Model, Op } from "sequelize";
import {
  IsImageFile,
  TranferFileMulterToString,
} from "../config/helper.js";
import sequelize from "../config/mysql.js";
import User from "./user.js";

const TypeMessage = DataTypes.ENUM("text", "image", "file", "video", "system");

class Message extends Model {
  /**
   * When message is send to database
   * @param {String} content content of message
   * @param {TypeMessage} typeContent type of message
   * @param {String} roomId
   * @param {String} sender
   * @returns new message
   */
  static async createMessage(value, roomId, senderId) {
    const typeContent = Array.isArray(value)
      ? IsImageFile(value[0].filename)
        ? "image"
        : "file"
      : "text";
    const content = Array.isArray(value)
      ? value.map((file) => TranferFileMulterToString(file)).join(", ")
      : value; // if is list file, join with ','

    const message = await Message.create({
      content: content,
      typeContent: typeContent,
      senderId,
      roomId,
    });
    return message;
  }

  static async getMessagesByRoomId(
    roomId,
    startIndex,
    number,
    orderby,
    orderdirection,
    searchby,
    searchvalue
  ) {
    var searchOrderby;
    var searchTypeBy;

    switch (orderby) {
      case "createTime":
        searchOrderby = ["createTime"];
        break;
      default:
        break;
    }

    switch (searchby) {
      case "all":
        searchTypeBy = TypeMessage.values;
        break;
      case "text":
        searchTypeBy = ["text"];
        break;
      case "media":
        searchTypeBy = ["image", "video"];
        break;
      case "file":
        searchTypeBy = ["file"];
        break;
      default:
        break;
    }

    const messages = await Message.findAll({
      where: {
        roomId: roomId,
        content: {
          [Op.substring]: searchvalue,
        },
        typeContent: { [Op.in]: searchTypeBy },
      },
      attributes: {
        exclude: ["roomId", "senderId"],
      },
      include: {
        model: User, //Get sender data
        as: "sender",
        attributes: {
          exclude: ["numberEvent", "numberFollower"],
        },
      },
      limit: number,
      offset: startIndex,
      order: [[...searchOrderby, orderdirection]],
    });
    return messages;
  }

  static async getMessageByIdsAndType(messageIds) {
    const messages = await Message.findAll({
      where: {
        id: {
          [Op.in]: messageIds,
        }
      }
    });

    return messages;
  }

  static async getAllMessages(
    startIndex,
    number,
    orderby,
    orderdirection,
    searchby,
    searchvalue
  ) {
    var searchOrderby;
    var searchTypeBy;

    switch (orderby) {
      case "createTime":
        searchOrderby = ["createTime"];
        break;
      default:
        break;
    }

    switch (searchby) {
      case "all":
        searchTypeBy = TypeMessage.values;
        break;
      case "text":
        searchTypeBy = ["text"];
        break;
      case "media":
        searchTypeBy = ["image", "video"];
        break;
      case "file":
        searchTypeBy = ["file"];
        break;
      default:
        break;
    }

    var searchWhere = {
      content: {
        [Op.substring]: searchvalue,
      },
      typeContent: { [Op.in]: searchTypeBy },
    };

    const messages = await Message.findAll({
      where: searchWhere,
      attributes: {
        exclude: ["senderId"],
      },
      include: {
        model: User, //Get sender data
        as: "sender",
        attributes: {
          include: ["password"],
        },
      },
      limit: number,
      offset: startIndex,
      order: [[...searchOrderby, orderdirection]],
    });
    return messages;
  }

  static async checkIsSender(messageIds, senderId) {
    const rs = await Message.count({
      where: {
        senderId: senderId,
        id: {
          [Op.in]: messageIds,
        }
      }
    });

    return rs === messageIds.length;
  }

  static async deleteMessageInRoom(roomId) {
    const rs = await Message.destroy({
      where: {
        roomId: roomId,
      },
    });
    return rs;
  }

  static async deleteMessageById(messageIds) {
    const rs = await Message.destroy({
      where: {
        id: {
          [Op.in]: messageIds
        }
      }
    });

    return rs;
  }

  // static async getImages(startIndex, number, roomId) {
  //   const messages = await Message.findAll({
  //     where: { roomId: roomId, typeContent: "image" },
  //     order: [["timeCreate", "DESC"]],
  //     // include: {
  //     //     model: User, //Get sender data
  //     //     as: "sender",
  //     //     attribute: [
  //     //         ["id", "senderId"],
  //     //         ["name", "senderName"],
  //     //         ["imageUri", "senderImageUri"],
  //     //     ],
  //     // },
  //     limit: number,
  //     offset: startIndex,
  //   });
  //   return messages;
  // }

  // static async getFiles(startIndex, number, roomId) {
  //   const messages = await Message.findAll({
  //     where: { roomId: roomId, typeContent: "file" },
  //     order: [["timeCreate", "DESC"]],
  //     // include: {
  //     //     model: User, //Get sender data
  //     //     as: "sender",
  //     //     attribute: [
  //     //         ["id", "senderId"],
  //     //         ["name", "senderName"],
  //     //         ["imageUri", "senderImageUri"],
  //     //     ],
  //     // },
  //     limit: number,
  //     offset: startIndex,
  //   });
  //   return messages;
  // }
}

Message.init(
  {
    id: {
      type: DataTypes.UUID,
      primaryKey: true,
      defaultValue: DataTypes.UUIDV4,
    },
    createTime: {
      type: DataTypes.DATE,
      allowNull: false,
      defaultValue: DataTypes.NOW,
    },
    content: {
      type: DataTypes.STRING,
      allowNull: false,
      defaultValue: "",
    },
    typeContent: {
      type: TypeMessage,
      allowNull: false,
      defaultValue: "text",
    },
  },
  {
    sequelize,
    modelName: "Message",
  }
);

export default Message;
export { TypeMessage };
