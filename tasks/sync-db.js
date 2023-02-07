
let times = 0;

const syncDb = () => {
    times++;
  console.log('running a task every 5 seconds', times);

  return times;
}

module.exports = {
    syncDb
}