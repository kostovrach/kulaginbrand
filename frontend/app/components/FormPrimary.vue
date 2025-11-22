<template>
    <section :class="['form-primary', `form-primary--${props.theme}`]">
        <div class="form-primary__container">
            <h2 class="form-primary__title">{{ props.title }}</h2>
            <div class="form-primary__body">
                <div class="form-primary__subtitle">
                    <picture class="form-primary__subtitle-image-container">
                        <img class="form-primary__subtitle-image" :src="props.image" alt="#" />
                    </picture>
                    <ClientOnly>
                        <p
                            class="form-primary__subtitle-text"
                            v-if="props.description"
                            v-html="props.description"
                        ></p>
                    </ClientOnly>
                </div>
                <form class="form-primary__form" @submit.prevent="submitForm">
                    <div class="form-primary__inputbox">
                        <input
                            id="name"
                            v-model="form.name"
                            type="text"
                            placeholder="Иван Иванович"
                            autocomplete="name"
                        />
                        <label for="name">Ваше имя</label>
                        <span class="form-primary__error">{{ errors.name }}</span>
                    </div>
                    <div class="form-primary__inputbox">
                        <InputMask
                            id="tel"
                            v-model="form.tel"
                            mask="+9 (999) 999-99-99"
                            placeholder="+_ (___) ___-__-__"
                            autocomplete="tel"
                        />
                        <label for="tel">Телефон</label>
                    </div>
                    <div class="form-primary__inputbox">
                        <input
                            id="email"
                            v-model="form.email"
                            type="email"
                            placeholder="example@yandex.ru"
                            autocomplete="email"
                        />
                        <label for="email">Электронная почта</label>
                        <span class="form-primary__error">{{ errors.email }}</span>
                    </div>
                    <label class="form-primary__agreement" for="agreement">
                        <div class="form-primary__agreement-checkbox">
                            <input v-model="form.checkbox" type="checkbox" id="agreement" />
                        </div>
                        <p class="form-primary__agreement-label">
                            Я даю согласие на обработку персональных в соотвествии с:
                            <button
                                type="button"
                                v-for="(policy, idx) in policies"
                                :key="policy.id"
                                @click.prevent="
                                    openDocsModal(
                                        policy.title,
                                        policy.date_updated ?? policy.date_created,
                                        policy.content
                                    )
                                "
                            >
                                {{ policy.title.toLowerCase() }}
                                <template v-if="idx + 1 !== policies?.length">
                                    <span>,</span>
                                </template>
                            </button>
                        </p>
                    </label>

                    <button class="form-primary__button" type="submit" :disabled="isSubmitting">
                        <span class="form-primary__button-text">
                            {{ isSubmitting ? 'Отправка...' : 'Отправить' }}
                        </span>
                        <span class="form-primary__button-icon"><SvgSprite type="arrow" /></span>
                    </button>
                    <span class="form-primary__error--general">
                        {{ errors.general || errors.agreement }}
                    </span>
                </form>
            </div>
        </div>
    </section>
</template>

<script setup lang="ts">
    import { ModalsDocs } from '#components';
    import { useModal } from 'vue-final-modal';
    import type { IPolicy } from '~~/interfaces/policy';

    const props = withDefaults(
        defineProps<{
            theme?: 'dark' | 'light';
            image: string;
            title: string;
            description: string;
        }>(),
        {
            theme: 'dark',
        }
    );

    const { content: policies, status: policiesStatus } = useCms<IPolicy[]>('policies');

    function openDocsModal(title: string, date: string, content: string) {
        const { open: openModal, close: closeModal } = useModal({
            component: ModalsDocs,
            attrs: {
                dateUpdated: date,
                title,
                content,
                status: policiesStatus.value,
                onClose() {
                    closeModal();
                },
            },
        });
        openModal();
    }

    // form data
    const form = reactive({
        name: '',
        tel: '',
        email: '',
        checkbox: true,
    });

    const errors = reactive({
        name: '',
        email: '',
        message: '',
        general: '',
        agreement: '',
    });

    const isSubmitting = ref(false);

    // validation
    function validate() {
        let valid = true;

        errors.email = form.email ? (/\S+@\S+\.\S+/.test(form.email) ? '' : 'Неверный e-mail') : '';
        errors.general =
            !form.tel && !form.email ? 'Заполните хотя бы одно из полей контактной информации' : '';
        errors.agreement = !form.checkbox ? 'Необходимо дать согласие на обработку данных' : '';

        if (errors.email || errors.general || errors.agreement) valid = false;

        return valid;
    }

    // sending
    async function submitForm() {
        if (!validate()) return;
        isSubmitting.value = true;

        const res = await $fetch('/api/mail/', {
            method: 'POST',
            body: form,
        });

        if (res.ok) {
            form.name = '';
            form.tel = '';
            form.email = '';
            isSubmitting.value = false;
        } else {
            alert('Ошибка отправки данных, повторите попытку позже');
            throw new Error('Ошибка отправки данных, повторите попытку позже');
        }
    }
</script>

<style lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .form-primary {
        $p: &;

        max-height: 100%;
        color: inherit;
        background-color: inherit;

        &--dark {
            #{$p}__button {
                @include button-secondary(
                    $padding: rem(14) rem(32),
                    $border-color: $c-accent,
                    $background: transparent
                );
            }
        }
        &--light {
            #{$p}__button {
                @include button-secondary($padding: rem(14) rem(32));
            }
        }
        &__container {
            height: 100%;
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            align-content: space-between;
            gap: rem(32);
            @include horizontal-max-height;
            @media (max-width: 768px) {
                grid-template-columns: repeat(4, auto);
            }
        }
        &__title {
            grid-column: span 4;
            @include block-title($max-width: 20ch);
        }
        &__body {
            grid-column: 2 / span 3;
            grid-row: 2;
        }
        &__subtitle {
            display: flex;
            align-items: center;
            gap: rem(16);
            &-image-container {
                max-width: rem(105);
                aspect-ratio: 1;
            }
            &-image {
                width: 100%;
                height: 100%;
                object-fit: cover;
            }
            &-text {
                max-width: 40ch;
                text-transform: uppercase;
                font-size: lineScale(32, 20, 480, 1440);
                font-weight: $fw-bold;
                line-height: 1.2;
                a {
                    color: $c-accent;
                    @media (pointer: fine) {
                        &:hover {
                            opacity: 0.8;
                        }
                    }
                }
            }
        }
        &__form {
            max-width: rem(480);
            display: flex;
            flex-direction: column;
            gap: rem(16);
            margin-top: rem(32);
        }
        &__inputbox {
            position: relative;
            width: 100%;
            height: rem(48);
            transition: opacity $td $tf;
            &::before {
                content: '';
                position: absolute;
                left: 0;
                bottom: 0;
                width: 0;
                height: rem(2);
                background-color: currentColor;
                transition: width $td $tf;
            }
            @media (pointer: fine) {
                &:hover {
                    &::before {
                        width: 100%;
                    }
                    input,
                    label {
                        opacity: 0.75;
                    }
                }
            }
            &:has(input:focus),
            &:has(input:not(:placeholder-shown)) {
                &::before {
                    width: 100%;
                }
                input,
                label {
                    opacity: 1;
                }
            }
            input,
            label {
                opacity: 0.5;
            }
            input {
                width: 100%;
                height: 100%;
                color: inherit;
                text-transform: uppercase;
                font-size: lineScale(24, 18, 480, 1440);
                font-weight: $fw-semi;
                background-color: transparent;
                &::placeholder {
                    opacity: 0;
                    transition: opacity $td $tf;
                }
                &:focus::placeholder,
                &:not(:placeholder-shown)::placeholder {
                    opacity: 1;
                }
            }
            label {
                position: absolute;
                left: 0;
                top: 50%;
                translate: 0 -50%;
                text-transform: uppercase;
                color: $c-9E9595;
                font-size: lineScale(32, 24, 480, 1440);
                font-weight: $fw-semi;
                will-change: font-size, translate;
                pointer-events: none;
                transition: all $td $tf;
            }
            &:has(input:focus) label,
            &:has(input:not(:placeholder-shown)) label {
                font-size: rem(12);
                translate: 0 rem(-32);
            }
        }
        &__agreement {
            display: flex;
            align-items: center;
            gap: rem(8);
            &-checkbox {
                @include checkbox;
            }
            &-label {
                font-size: rem(14);
                line-height: 1.5;
                > button,
                a {
                    cursor: pointer;
                    display: inline-flex;
                    color: $c-accent;
                    text-decoration: underline;
                    margin-right: 0.5ch;
                    @media (pointer: fine) {
                        &:hover {
                            text-decoration: none;
                        }
                    }
                }
            }
        }
        &__error {
            position: absolute;
            top: rem(0);
            right: 0;
            text-transform: uppercase;
            font-size: rem(12);
            white-space: nowrap;
            letter-spacing: rem(1);
            color: red;
            font-weight: $fw-semi;
            pointer-events: none;
            &--general {
                height: 1em;
                text-align: center;
                align-self: center;
                text-transform: uppercase;
                font-size: rem(12);
                white-space: nowrap;
                letter-spacing: rem(1);
                color: red;
                font-weight: $fw-semi;
                pointer-events: none;
            }
        }
    }

    @media (max-width: 768px) {
        .form-primary {
            &__container {
                gap: rem(64);
            }
            &__body {
                grid-column: 1 / span 4;
            }
            &__subtitle {
                &-image-container {
                    display: none;
                }
            }
        }
    }
</style>
