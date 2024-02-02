const Discord = require("discord.js");
const { dump } = require('./config/config.json');
const client = new Discord.Client({ intents: 32767 });
const cfg = require('./config/config.json')
const { createGzip } = require('zlib')
const fs = require('fs')
const mysqldump = require('mysqldump')
const del = require('del')


client.login(cfg.token);


const executeDump = async () => {
    if(!dump || typeof dump != 'object' || !dump.host  || !dump.database || !dump.user){
        console.error('hope-save Algo deu errado, você definiu de forma incorreta sua config.json')
        return
    }
    const date = new Date()
    const folder = './cache'
    const fileName = `backup-database.sql`
    const fileDir = `${folder}/${fileName}`
    const fileZip = fileDir+'.gz'
    if (!fs.existsSync(folder)){
        fs.mkdirSync(folder)
    }
    try {
        await mysqldump({
            connection: {
                host: dump.host,
                user: dump.user,
                password: dump.password,
                database: dump.database,
            },
            dumpToFile: fileDir
        })
    } catch (err) {
        console.log('[ERRO] Ao criar o arquivo.')
        return false
    }
    const zip = createGzip()

    const read = fs.createReadStream(fileDir)
    const write = fs.createWriteStream(fileZip)
    read.pipe(zip).pipe(write)
    await new Promise(r => setTimeout(r,1000))
    del(fileDir).catch(() => {})

    return fileZip
}

const taskDump = async () => {
    if(!dump || typeof dump != 'object' || !dump.database){
        console.error('hope-save Algo deu errado, você definiu de forma incorreta sua config.json')
        return
    } 
    const log = client.channels.cache.get("1202212848575725598")
    const fileDir = await executeDump()


    var currentdate = new Date();
    var datetime = "" + currentdate.getDate() + "/"
        + (currentdate.getMonth() + 1) + "/"
        + currentdate.getFullYear() + " | "
        + currentdate.getHours() + ":"
        + currentdate.getMinutes() + ":"
        + currentdate.getSeconds();

    let namedb = dump.database.toUpperCase()

    if(fileDir){
        try {
            await log.send({
                content: `\`\`\`ini\n[DATABASE ${namedb}]: BACKUP AUTOMÁTICO\n[DATA]: ${datetime}\`\`\``,
                files: [String(fileDir)]
            })
        } catch (err) {
            console.log(err)
            console.log('[ERRO] Ao enviar o arquivo para o servidor')
        }
    }
    console.log(fileDir)
    setTimeout(taskDump, (dump.cooldown || 10) * 60 * 1000)
}

setTimeout(taskDump, (dump.cooldown || 10)  * 60 * 1000)
console.log('hope-save conectado!')