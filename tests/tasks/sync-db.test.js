const { syncDb } = require("../../tasks/sync-db")


describe('Pruebas en sync-db', () =>{

    test('debe ejecutar el proceso 2 veces', () => { 
        syncDb();
        const times = syncDb();
        console.log('Se llamo', times);

        expect(times).toBe(2);
     })
})