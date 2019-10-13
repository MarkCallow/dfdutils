/* -*- tab-width: 4; -*- */
/* vi: set sw=2 ts=4 expandtab: */

/*
 * ©2019 Mark Callow.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

/**
 * @internal
 * @file dfd2vk.c
 *
 * @author Mark Callow, Edgewise Consulting.
 */

#include <KHR/khr_df.h>
#include "dfd.h"

/**
 * @internal
 * @~English
 * @brief Return a VkFormat matching a DFD.
 *
 * @param[in] dfd    Pointer to the DFD.
 *
 * @return      The matching VkFormat enum or VK_FORMAT_UNDEFINED if not
 *              matched.
 */
enum VkFormat dfd2vk(uint32_t *dfd)
{
#include "dfd2vk.inl"
}
