import importTemplate from "../../utils/importTemplate.js";

export default {
    data() {
        return {
            hours: 0,
            minutes: 0,
            seconds: 0,
        }
    },
    computed: {
        ...Vuex.mapState({
            Locales : state => state.Locales,
            isPhoneType : state => state.isPhoneType,
            userPhone : state => state.userPhone,
        })
    },
    methods: {
        ...Vuex.mapMutations({
            setIsPhoneActive: "setIsPhoneActive",
        }),
        keyHandler(e) {
            if (e.which == 27) {
                postNUI('close');
                this.setIsPhoneActive(false)
            }
        },
        startCountdown() {
            this.updateTime();
            setInterval(() => {
                if (this.userPhone.time > 0) {
                this.userPhone.time = this.userPhone.time - 1000;
                this.updateTime();
                }
            }, 1000);
        },
        updateTime() {
            const totalSeconds = this.userPhone.time / 1000; // Lua'dan milisaniye olarak geliyor
            this.hours = Math.floor(totalSeconds / 3600);
            this.minutes = Math.floor((totalSeconds % 3600) / 60);
            this.seconds = Math.floor(totalSeconds % 60);
        },
        StopJob() {
            postNUI('stopDuty');
            postNUI('close');
            this.setIsPhoneActive(false);
        }
    },
    mounted() {
        window.addEventListener("message", this.messageHandler);
        window.addEventListener("keyup", this.keyHandler);
    },
    beforeDestroy() {
        window.removeEventListener("message", this.messageHandler);
        window.removeEventListener("keyup", this.keyHandler);
    },
    created() {
        this.startCountdown();
    },
    template: await importTemplate("./app/pages/phone/index.html")
};